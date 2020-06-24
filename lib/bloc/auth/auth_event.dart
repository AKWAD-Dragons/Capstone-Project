import 'dart:io';

abstract class AuthEvent {}

/// Used in LogoField widget
/// Pass selected logo to bloc, or pass nothing, to remove the current logo
class LogoImageUpdated extends AuthEvent {
  File logoImage;

  LogoImageUpdated({this.logoImage});
}

class LoginClicked extends AuthEvent {
  String email;
  String password;

  LoginClicked(this.email, this.password);
}

class SignupClicked extends AuthEvent {
  String email;
  String password;
  String confirmPasswrod;

  SignupClicked(this.email, this.password, this.confirmPasswrod);
}

class ResetPassClicked extends AuthEvent {
  String email;

  ResetPassClicked(this.email);
}

class PasswordChangeRequested extends AuthEvent {
  String email;
  String newPassword;
  String oldPassword;
  String confirmPassword;
  String token;

  PasswordChangeRequested(this.email, this.oldPassword, this.newPassword,
      this.confirmPassword, this.token);
}
