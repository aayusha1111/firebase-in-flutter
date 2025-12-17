import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_project/features/authentication/bloc/auth_bloc.dart';
import 'package:new_project/firebase_options.dart';
import 'package:new_project/pages/signup_page.dart';
import 'package:new_project/test_bloc/api_test.dart';
import 'package:new_project/test_bloc/test.dart';
import 'package:new_project/test_bloc/test_bloc.dart';
import 'package:new_project/utils/route_generator.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Top-level function for background notification response
@pragma('vm:entry-point')
void backgroundNotificationHandler(
    NotificationResponse notificationResponse) {
  if (notificationResponse.payload != null) {
    final data = jsonDecode(notificationResponse.payload!);
    // Note: You cannot directly navigate from background.
    // You can handle data or schedule local notifications.
    print('Background notification clicked: ${data}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  initializeLocalNotification();

  runApp(const MyApp());
}

void initializeLocalNotification() {
  var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosSettings = const DarwinInitializationSettings();

  var initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveBackgroundNotificationResponse: backgroundNotificationHandler,
    onDidReceiveNotificationResponse: (details) {
      if (details.payload != null) {
        final data = jsonDecode(details.payload!);
        navigatorKey.currentState?.pushNamed(
          Routes.notificationsRoute,
          arguments: NotificationPayload(
              title: data["title"], body: data["body"]),
        );
      }
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    checkPermission();
    getNotification();
    getFcmToken();
  }

  checkPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  getNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showSimpleNotification(
        message.notification?.title ?? "",
        message.notification?.body ?? "",
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigatorKey.currentState?.pushNamed(
        Routes.notificationsRoute,
        arguments: NotificationPayload(
          title: message.notification?.title,
          body: message.notification?.body,
        ),
      );
    });
  }

  getFcmToken() async {
    String? token = await messaging.getToken();
    print("FCM token: $token");
  }

  void showSimpleNotification(String title, String body) async {
    var androidDetails = const AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var iosDetails = const DarwinNotificationDetails();

    var platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
      payload: jsonEncode({"title": title, "body": body}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(create: (_) => CounterBloc()),
        BlocProvider<ApiBloc>(create: (_) => ApiBloc()),
        BlocProvider<AuthBloc>(create: (_) => AuthBloc())
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: false,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SignupPage(),
      ),
    );
  }
}

class NotificationPayload {
  final String? title;
  final String? body;

  NotificationPayload({this.title, this.body});
}
