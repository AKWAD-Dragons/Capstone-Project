import 'package:sercl/support/Auth/User.dart';

abstract class AuthState {}

class UserDataIs extends AuthState {
  AuthUser user;
  UserDataIs(this.user);
}

class EmailSent extends AuthState{
  EmailSent();
}

class PasswordIsChanged extends AuthState {
  bool success;
  PasswordIsChanged(this.success);
}