import 'package:new_project/features/authentication/model/user.dart';

abstract class AuthEvent {}
class SignupEvent extends AuthEvent{
User?user;

SignupEvent(this.user);
}

class LoginEvent extends AuthEvent{
 UserLogin? userLogin;

  LoginEvent(this.userLogin);
}
