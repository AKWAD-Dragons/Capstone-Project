import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/bloc/auth/auth_state.dart';
import 'package:sercl/bloc/auth/bloc.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/support/router.gr.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  Map<String, bool> obscurePassword = {
    AppStrings.currentPassword: true,
    AppStrings.newPassword: true,
    AppStrings.confirmNewPassword: true,
  };

  AuthBloc authBloc = GetIt.instance<AuthBloc>();
  ProfileBloc profileBloc = GetIt.instance<ProfileBloc>();

  StreamSubscription<AuthState> authSubject;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    authSubject = GetIt.instance<AuthBloc>().authStateSubject.listen((state) {
      if (state is PasswordIsChanged && state.success) {
        Fluttertoast.showToast(
            msg: AppStrings.passwordChangeSuccess,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: AppColors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.accentColor,
        title: Text(AppStrings.changePassword),
        iconTheme: IconThemeData(
          color: AppColors.white
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(AppDimens.parentContainerRadius),
                topRight: Radius.circular(AppDimens.parentContainerRadius))),
        child: SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(AppDimens.screenPadding),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                passwordTextField(
                    AppStrings.currentPassword, _currentPasswordController),
                SizedBox(height: 20,),
                passwordTextField(
                    AppStrings.newPassword, _newPasswordController),
                SizedBox(height: 20,),
                passwordTextField(AppStrings.confirmNewPassword,
                    _confirmPasswordController),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30, left: AppDimens.screenPadding),
          child: saveButton(),
        ),
      ],
    ),
        ),
    )
    );
  }

  Widget saveButton() {
    return InkWell(
      onTap: () {
        // 1- Hide keyboard on button clikc
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }

        // 2- validate
        if (formKey.currentState.validate()) {
          //3- send data
          String email;
          String token;
          if (profileBloc.sp.authUser != null) {
            email = profileBloc.sp.authUser.email;
            token = profileBloc.sp.authUser.token;
          } else {
            email = profileBloc.tech.authUser.email;
            token = profileBloc.tech.authUser.token;
          }

          authBloc.dispatch(PasswordChangeRequested(
            email,
            _currentPasswordController.text,
            _newPasswordController.text,
            _confirmPasswordController.text,
            token,
          ));
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
                    AppStrings.changePassword,
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Image.asset(
                  "assets/images/forward.png",
                  width: 20,
                  height: 20,
                )
              ],
            ),
          )),
    );
  }

  Widget passwordTextField(String hint, TextEditingController controller) {
    return TextFormField(
      obscureText: obscurePassword[hint],

      validator: (value) {
        if (value.trim().isEmpty)
          return AppStrings.passwordRequired;
        if (value.length < 8) return AppStrings.invalidPassword;
        if (hint != AppStrings.currentPassword && _confirmPasswordController.text != _newPasswordController.text){
          return AppStrings.passwordDontMatch;
        }
      },

      controller: controller,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          child: Container(
              margin: EdgeInsets.only(left: 10, right: 16),
              child: obscurePassword[hint]
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility)),
          onTap: () {
            setState(() {
              obscurePassword[hint] = !obscurePassword[hint];
            });
          },
        ),
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.border),
      ),
    );
  }
}
