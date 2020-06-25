import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sercl/Utilities/FCMProvider.dart';
import 'package:sercl/bloc/auth/auth_bloc.dart';
import 'package:sercl/bloc/auth/auth_event.dart';
import 'package:sercl/bloc/auth/auth_state.dart';
import 'package:sercl/bloc/profile/bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/dimens.dart';
import 'package:sercl/resources/strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sercl/support/router.gr.dart';

const String ROUTE = "/";

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  StreamSubscription sub;

  /* Used to show or hide password based on eye icon in the password field */
  bool showPassword = false;
  AuthBloc bloc = GetIt.instance<AuthBloc>();
  final FCMProvider _fcmProvider = GetIt.instance.get<FCMProvider>();
  final ProfileBloc _profileBloc = GetIt.instance<ProfileBloc>();
  GlobalKey<FormState> formKey = GlobalKey();
  StreamSubscription<AuthState> authSubject;


  @override
  void initState() {
    super.initState();
    this.authSubscription();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            screenHeader(),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  emailField(),
                  SizedBox(height: 10),
                  passwordField(),
                  Container(
                    margin:
                        EdgeInsets.only(left: AppDimens.screenPadding, top: 60),
                    child: loginButton(),
                  ),
                  forgotPassword()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void authSubscription() {
    authSubject = bloc.authStateSubject.listen((state) {
      if (!(state is UserDataIs)) {
        return;
      }
      UserDataIs userIs = state;
      if (userIs.user.id != null) {
        authSubject.cancel();
        if (userIs.user.role == CodeStrings.sp) {
          ///TODO: Navigate to home screen
          sub = _profileBloc.subject.listen((state) {
            if (state is CompanyInfoIs) {
              if (!state.sp.verify) {
                ///TODO: Navigate to onBoarding Home screen
                sub.cancel();
              } else {
                MainRouter.navigator.pushReplacementNamed(MainRouter.parent);
                sub.cancel();
              }
            }
          });
        } else if (userIs.user.role == CodeStrings.worker) {
          sub = _profileBloc.subject.listen((state) {
            if (state is WorkerIs) {
              if (state.worker == null) return;
              sub.cancel();
              MainRouter.navigator
                  .pushNamedAndRemoveUntil(MainRouter.unknownScreen, ((_) => false));
            }
          });
          ///TODO: Navigate to home screen
        }
      }
    });
  }

  Widget emailField() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: emailController,
        validator: (value) {
          if (value.trim().isEmpty) {
            return AppStrings.emailRequired;
          }
          if (!EmailValidator.validate(value.trim())) {
            return AppStrings.invalidEmail;
          }

          return null;
        },
        decoration: InputDecoration(
          hintText: AppStrings.email,
          hintStyle: TextStyle(color: AppColors.border),
          prefixIcon: Container(
            width: 10,
            margin: EdgeInsets.only(left: 10, right: 16),
            child: Image.asset(
              "assets/images/person.png",
              width: 5,
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordField() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        controller: passwordController,
        validator: (value) {
          if (value.isEmpty) {
            return AppStrings.passwordRequired;
          }

          if (value.length < 8) {
            return AppStrings.invalidPassword;
          }
        },
        obscureText: showPassword ? false : true,
        decoration: InputDecoration(
            hintText: AppStrings.password,
            hintStyle: TextStyle(color: AppColors.border),
            prefixIcon: Container(
              margin: EdgeInsets.only(left: 10, right: 16),
              child: Image.asset(
                "assets/images/password.png",
                width: 15,
                height: 15,
              ),
            ),
            suffixIcon: InkWell(
              child: Container(
                  margin: EdgeInsets.only(left: 10, right: 16),
                  child: showPassword
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off)),
              onTap: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            )),
      ),
    );
  }

  Widget loginButton() {
    return InkWell(
      onTap: () {
        if (formKey.currentState.validate()) {
          // Hide keyboard on button click
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          ///TODO: Dispatch Login event

        }
      },
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50))),
          width: double.infinity,
          height: 60,
          child: Container(
            padding: EdgeInsets.only(
                left: AppDimens.buttonPadding, right: AppDimens.buttonPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    AppStrings.login,
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Image.asset(
                  "assets/images/forward.png",
                  width: 15,
                  height: 15,
                )
              ],
            ),
          )),
    );
  }

  Widget screenHeader() {
    return Container(
      height: MediaQuery.of(context).size.width * 0.65,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 230,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/banner2.png"),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.only(
                left: AppDimens.screenPadding, right: AppDimens.screenPadding),
            height: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  AppStrings.login,
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  AppStrings.loginToSercl,
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return Container(
      padding: EdgeInsets.only(left: AppDimens.screenPadding, top: 20),
      child: InkWell(
        onTap: () {
          MainRouter.navigator.pushNamed(MainRouter.forgotPass);
        },
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            AppStrings.forgotPassword,
            style: TextStyle(
                color: AppColors.accentColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 1,
            color: AppColors.border,
          ),
          InkWell(
            onTap: () async {
              ///TODO: Navigate to Sign up screen
              MainRouter.navigator.pushReplacementNamed(MainRouter.unknownScreen);
              this.authSubscription();
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: AppDimens.screenPadding,
                  right: AppDimens.screenPadding,
                  top: 25,
                  bottom: 23),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      AppStrings.noAccount,
                      style:
                          TextStyle(color: AppColors.primaryColor, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    AppStrings.register.toUpperCase(),
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
