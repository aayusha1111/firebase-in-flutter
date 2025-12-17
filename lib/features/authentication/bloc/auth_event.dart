

import 'package:new_project/features/authentication/model/user.dart';

abstract class AuthEvent {}
class SignupEvent extends AuthEvent{
User?user;

SignupEvent(this.user);
}
