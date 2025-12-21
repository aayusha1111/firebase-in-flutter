import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/features/authentication/bloc/auth_event.dart';
import 'package:new_project/features/authentication/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthBloc() : super(AuthInitialState()) {
    on<SignupEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        QuerySnapshot userQuery = await firestore
            .collection('users')
            .where('emailAddress', isEqualTo: event.user?.email)
            .get();

        if (userQuery.docs.isNotEmpty) {
          emit(AuthErrorState("Email already in use"));
          return;
        }

        await firestore.collection('users').add({
          'name': event.user?.name,
          'address': event.user?.address,
          'emailAddress': event.user?.email,
          'password': event.user?.password,
          'identity': {
            'idType': event.user?.identity?.type,
            'url': event.user?.identity?.url,
          },
          'profileUrl': event.user?.profileUrl,
        });
        emit(AuthLoadedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoadedState());

      try {
        if (event.userLogin?.email != null &&
            event.userLogin?.password != null) {
          QuerySnapshot userQuery = await firestore
              .collection('users')
              .where('emailAddress', isEqualTo: event.userLogin!.email)
              .where('password', isEqualTo: event.userLogin!.password)
              .get();

          if (userQuery.docs.isNotEmpty) {
            emit(AuthLoadedState());
          } else {
            emit(AuthErrorState("Invalid email or password"));
          }
        } else {
          emit(AuthErrorState("Email or password is missing"));
        }
      } catch (e) {
        emit(AuthErrorState("Something went wrong:${e.toString()}"));
      }
    });
  }
}
