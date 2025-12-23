import 'package:flutter/material.dart';
import 'package:new_project/main.dart';
import 'package:new_project/pages/add_place_page.dart';
import 'package:new_project/pages/login_page.dart';
import 'package:new_project/pages/notification_page.dart';
import 'package:new_project/pages/places_list_page.dart';
import 'package:new_project/pages/signup_page.dart';
import 'package:new_project/utils/routes.dart';


class RouteGenerator {
  static navigateToPage(BuildContext context, String route,
      {dynamic arguments}) {
    Navigator.push(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
    );
  }

  static navigateToPageWithoutStack(BuildContext context, String route,
      {dynamic arguments}) {
    Navigator.pushAndRemoveUntil(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
      (route) => false,
    );
  }

    static Route<dynamic> generateRoute(RouteSettings settings) {
      switch (settings.name) {
        case Routes.notificationsRoute:
        NotificationPayload? payload=settings.arguments as NotificationPayload?;
          return MaterialPageRoute(builder: (_) => NotificationPage(notificationsPayload:payload));

          case Routes.loginRoute:
           return MaterialPageRoute(builder: (_) =>LoginPage());

           case Routes.signupRoute:
           return MaterialPageRoute(builder: (_)=>SignupPage());

           case Routes.addPlaceRoute:
           return MaterialPageRoute(builder: (_)=>AddPlacePage());

           case Routes.placeListRoute:
           return MaterialPageRoute(builder: (_)=>PlacesListScreen());

           
  
          
          default:
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          );
      }
    }
  }