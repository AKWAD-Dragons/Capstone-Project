import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/bloc/auth/bloc.dart';
import 'package:sercl/resources/res.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sercl/support/router.gr.dart';

const String ROUTE = "/ForgotPassword";

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
                    SizedBox(height: 30),
                    emailField(),
                    Container(
                      margin: EdgeInsets.only(
                          left: AppDimens.screenPadding, top: 60),
                      child: nextButton(),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
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
        },
        decoration: InputDecoration(
          hintText: AppStrings.email,
          hintStyle: TextStyle(color: AppColors.border),
          prefixIcon: Container(
            margin: EdgeInsets.only(left: 10, right: 16),
            child: Image.asset(
              "assets/images/person.png",
              width: 20,
              height: 20,
            ),
          ),
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
                    onTap: () => MainRouter.navigator.pop()),
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
                AppStrings.enterEmail,
                style: TextStyle(color: AppColors.white, fontSize: 16),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget nextButton() {
    return InkWell(
      onTap: () {
        if (formKey.currentState.validate()) {
          GetIt.instance<AuthBloc>()
              .dispatch(ResetPassClicked(emailController.text));
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
