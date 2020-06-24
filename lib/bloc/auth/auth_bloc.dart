import 'dart:async';
import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sercl/Utilities/FCMProvider.dart';
import 'package:sercl/bloc/auth/auth_event.dart';
import 'package:sercl/bloc/auth/auth_state.dart';
import 'package:sercl/bloc/bloc.dart';
import 'package:load/load.dart';
import 'package:sercl/resources/strings.dart';
import 'package:sercl/dialog_provider/dialog_models.dart';
import 'package:sercl/dialog_provider/dialog_service.dart';
import 'package:sercl/support/Auth/AppException.dart';
import 'package:sercl/support/Auth/AuthProvider.dart';
import 'package:sercl/support/Auth/EmailLoginMethod.dart';
import 'package:sercl/support/Auth/EmailSignupMethod.dart';
import 'package:sercl/support/Auth/User.dart';
import 'package:sercl/support/Fly/fly.dart';
import 'package:sercl/support/GraphClient/GraphQLBuilder.dart';
import 'package:sercl/support/router.gr.dart';

class AuthBloc extends BLoC<AuthEvent> {
  ///// Singleton

  final AuthProvider provider = GetIt.instance.get<AuthProvider>();
  final FCMProvider _fcmProvider = GetIt.instance.get<FCMProvider>();
  PublishSubject<AuthState> authStateSubject = PublishSubject();
  final DialogService _dialogService = GetIt.instance.get<DialogService>();

  File logoImg;
  Fly fly = GetIt.instance<Fly>();

  List<File> companyImages = List();
  Map<String, File> files = Map();
  AuthUser authUser;

  @override
  void dispatch(AuthEvent event) async {
    if (event is LoginClicked) {
      loginWithEmail(event.email, event.password)
          .catchError((onError) => _showErrorDialog(onError, true));
    }
    if (event is SignupClicked) {
      signupWithEmail(event.email, event.password, event.confirmPasswrod)
          .catchError((onError) => _showErrorDialog(onError, true));
    }
    if (event is LogoImageUpdated) {
      updateLogoImage(logo: event.logoImage);
    }
    if (event is ResetPassClicked) {
      resetPassword(event).catchError((onError) {
        hideLoadingDialog();
        if (onError is AppException) {
          GetIt.instance
              .get<DialogService>()
              .showDialog(ErrorDialog(message: onError.beautifulMsg));
        } else {
          GetIt.instance
              .get<DialogService>()
              .showDialog(ErrorDialog(message: onError.beautifulMsg));
        }
      });
    }

    if (event is PasswordChangeRequested) {
      changePassword(event).catchError((e) {
        authStateSubject.add(PasswordIsChanged(false));
        hideLoadingDialog();
        if (e is AppException) {
          GetIt.instance
              .get<DialogService>()
              .showDialog(ErrorDialog(message: e.beautifulMsg));
        } else {
          GetIt.instance
              .get<DialogService>()
              .showDialog(ErrorDialog(message: e.toString()));
        }
      });
    }
  }

  void _showErrorDialog(AppException onError, bool hideDialog) {
    if (hideDialog) hideLoadingDialog();
    if (onError is AppException) {
      _dialogService.showDialog(ErrorDialog(message: onError.beautifulMsg));
    } else {
      _dialogService.showDialog(ErrorDialog(message: AppStrings.errorOccured));
    }
  }

  Future<void> _updateFCMToken(String fcmToken) async {
    Node _updateFcmToken =
        Node(name: 'updatedFCM', args: {'fcm_token': fcmToken});

    if (authUser != null) {
      fly.addHeaders({"Authorization": "Bearer ${authUser.token}"});
      await fly.mutation([_updateFcmToken], parsers: {});
      print(
          '=========================FCM TOKEN UPDATED===========================');
    } else {
      print('USER IS NOT LOGGED IN!');
    }
  }

  void _registerToFCMRefreshToken() {
    _fcmProvider.setFCMBackgroundMessageHandler();
    _fcmProvider.fcmTokenSubject.listen((refreshedFCMToken) {
      _updateFCMToken(refreshedFCMToken);
    });
  }



  Future<void> signupWithEmail(
      String email, String password, String passwordConfrim) async {
    showLoadingDialog(tapDismiss: false);
    authUser = await provider.signUpWith(
        method: EmailSignupMethod(email, password, passwordConfrim));
    hideLoadingDialog();
    //authStateSubject.add(UserDataIs(null));
    await GetIt.instance<DialogService>()
        .showDialog(SuccessDialog(message: AppStrings.signupSuccess));
    MainRouter.navigator
        .pushNamedAndRemoveUntil(MainRouter.login, (_) => false);
  }

  Future<void> loginWithEmail(String email, String password) async {
    showLoadingDialog(tapDismiss: false);
    authUser =
        await provider.loginWith(method: EmailLoginMethod(email, password));
    await assertValidUserRole(authUser);
    _registerToFCMRefreshToken();
    hideLoadingDialog();
    Fly fly = GetIt.instance<Fly>();
    fly.addHeaders({"Authorization": "Bearer ${authUser.token}"});

    authStateSubject.add(UserDataIs(authUser));
  }

  Future<void> assertValidUserRole(AuthUser user) async {
    if (user.role != CodeStrings.sp && user.role != CodeStrings.worker) {
      await provider.logout();
      throw AppException(true, beautifulMsg: AppStrings.emailRegistered);
    }
  }

  /* If a file was passed to the function, set it to the current logo image, if not, remove the current logo image */
  void updateLogoImage({File logo}) {
    if (logo == null) {
      logoImg = null;
      return;
    }
    logoImg = logo;
  }

  Future<void> resetPassword(event) async {
    showLoadingDialog(tapDismiss: false);
    Node resetPass = Node(name: 'reset_password', args: {"email": event.email});
    dynamic results = await fly.mutation([resetPass], parsers: {});
    if (results["error"] == null) {
      hideLoadingDialog();
      GetIt.instance.get<DialogService>().showDialog(SuccessDialog(
          message: AppStrings.checkEmail, title: AppStrings.resetDone));
    } else {
      hideLoadingDialog();
      GetIt.instance
          .get<DialogService>()
          .showDialog(ErrorDialog(message: AppStrings.errorOccured));
    }
  }

  Future<void> changePassword(PasswordChangeRequested event) async {
    showLoadingDialog(tapDismiss: false);

    Node reAuth_userMutation = Node(
      name: "reAuth_user",
      args: {
        "type": "email",
        "credentials": {
          "email": event.email,
          "oldPassword": event.oldPassword,
          "newPassword": event.newPassword,
          "confirmPassword": event.confirmPassword,
          "token": event.token,
        },
      },
      cols: ['jwtToken', 'expire', 'id', 'role'],
    );

    Map results = await fly
        .mutation([reAuth_userMutation], parsers: {"reAuth_user": AuthUser()});
    provider.setToken(results["jwtToken"]);
    print(results["jwtToken"]);

    authStateSubject.add(PasswordIsChanged(true));

    hideLoadingDialog();
  }

  removeUser() async {}
}
