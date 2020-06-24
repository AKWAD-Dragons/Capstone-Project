import 'package:flutter/material.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/dimens.dart';
import 'package:sercl/resources/strings.dart';
import 'package:sercl/support/router.gr.dart';

const String ROUTE = "/ResetPass";

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  /* Used to show or hide password based on eye icon in the password field */
  bool showError = false;
  Map<String, bool> obscurePassword = {
    AppStrings.newPassword: true,
    AppStrings.confirmNewPassword: true
  };

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            screenHeader(),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  passwordField(passwordController, AppStrings.newPassword),
                  SizedBox(height: 10),
                  passwordField(
                      confirmPasswordController, AppStrings.confirmNewPassword),
                  passwordsErrorWidget(),
                  Container(
                    margin:
                        EdgeInsets.only(left: AppDimens.screenPadding, top: 60),
                    child: nextButton(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget screenHeader() {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 230,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/banner1.png"),
                  fit: BoxFit.cover)),
        ),
        Container(
          margin: EdgeInsets.only(
              left: AppDimens.screenPadding, right: AppDimens.screenPadding),
          height: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: InkWell(
                  child: Image.asset(
                    "assets/images/back.png",
                    width: 25,
                    height: 25,
                  ),
                  onTap: () => MainRouter.navigator.pop(context),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                AppStrings.resetPassword,
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                AppStrings.enterNewPassword,
                style: TextStyle(color: AppColors.white, fontSize: 16),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget passwordField(TextEditingController controller, String label) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value.isEmpty) {
                return AppStrings.passwordRequired;
              }

              if (value.length < 6) {
                return AppStrings.invalidPassword;
              }
            },
            obscureText: obscurePassword[label],
            decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(color: AppColors.border),
                prefix: Container(
                  margin: EdgeInsets.only(left: 10, right: 16),
                  child: Image.asset(
                    "assets/images/password.png",
                    width: 20,
                    height: 20,
                  ),
                ),
                suffixIcon: InkWell(
                  child: Container(
                      margin: EdgeInsets.only(left: 10, right: 16),
                      child: obscurePassword[label]
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                  onTap: () {
                    setState(() {
                      obscurePassword[label] = !obscurePassword[label];
                    });
                  },
                )),
          )
        ],
      ),
    );
  }

  Widget passwordsErrorWidget() {
    return Visibility(
      visible: showError,
      child: Container(
        padding: EdgeInsets.all(AppDimens.screenPadding),
        child: Text(
          AppStrings.passwordDontMatch,
          style: TextStyle(color: AppColors.errorColor),
        ),
      ),
    );
  }

  Widget nextButton() {
    return InkWell(
      onTap: () {
        setState(() {
          showError = false;
        });
        if (formKey.currentState.validate()) {
          if (confirmPasswordController.text.trim() !=
              passwordController.text.trim()) {
            setState(() {
              showError = true;
            });
          }
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
                    AppStrings.resetPassword,
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
}
