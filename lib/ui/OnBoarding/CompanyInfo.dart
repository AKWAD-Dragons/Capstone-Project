import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/bloc/auth/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sercl/support/router.gr.dart';
import 'LogoField.dart';
import 'package:sercl/resources/strings.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/dimens.dart';
import 'package:flutter/services.dart';
import 'ScreenHeader.dart';
import 'CompanyImagesField.dart';
import 'OnBoardingBackButton.dart';

const String ROUTE = "/CompanyInfo";

class CompanyInfo extends StatefulWidget {
  @override
  _CompanyInfoState createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
  GlobalKey<FormState> formKey = GlobalKey();
  AuthBloc authBloc;
  bool logoExists = false;
  StreamSubscription sub;
  ProfileBloc bloc = GetIt.instance<ProfileBloc>();

  TextEditingController companyName = TextEditingController();
  TextEditingController companyBio = TextEditingController();
  int _radioValue = 0;

  /* Is false when we first launch the screen, so the screen won't get popped as if we clicked on the save button */
  bool submitClicked = false;

  @override
  void initState() {
    sub = bloc.subject.listen((profileState) {
      if (!(profileState is CompanyInfoIs)) {
        return;
      }

      CompanyInfoIs state = profileState;

      if (state.submited && submitClicked) {
        MainRouter.navigator.pop(context);
        Fluttertoast.showToast(
          msg: AppStrings.companyInfoSuccess,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }


      if (companyName.text != state.sp.name) companyName.text = state.sp.name;
      if (companyBio.text != state.sp.bio) companyBio.text = state.sp.bio;
      _radioValue=state.sp.small_company?0:1;
      setState(() {
        logoExists =
            state.sp.logo == null && state.sp.logo_link == null ? false : true;
      });
    });

    bloc.dispatch(CompanyPageLaunched());

    super.initState();
  }

  @override
  void dispose() {
    this.sub.cancel();
    super.dispose();
  }

  void infoChanged() {
    bloc.dispatch(CompanyInfoUpdated(companyName.text, companyBio.text,_radioValue==0));
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black87));
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ScreenHeader(AppStrings.companyInfo),
        Expanded(
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: AppDimens.screenPadding,
                    right: AppDimens.screenPadding,
                    bottom: AppDimens.screenPadding),
                child: form(),
              ),
              nextButton(),
            ],
          )),
        ),
      ],
    )));
  }

  Widget form() {
    return Form(
        key: formKey,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LogoField(),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              nameField(),
              SizedBox(
                height: 10,
              ),
              bioField(),
              SizedBox(
                height: 10,
              ),
              CompanyImagesField(),
              SizedBox(
                height: 10,
              ),
              smallCompanyField(),
            ],
          ),
        ));
  }

  Widget nameField() {
    return Container(
      margin: EdgeInsets.only(
          top: AppDimens.screenPadding, bottom: AppDimens.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.companyName,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value.trim().isEmpty) return AppStrings.companyNameRequired;
            },
            textCapitalization: TextCapitalization.words,
            controller: companyName,
            decoration: InputDecoration(
                hintText: AppStrings.companyNameHint,
                hintStyle: TextStyle(color: AppColors.hint, fontSize: 16)),
          )
        ],
      ),
    );
  }

  Widget bioField() {
    return Container(
      margin: EdgeInsets.only(
          top: AppDimens.screenPadding, bottom: AppDimens.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.companyBio,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            maxLines: 3,
            validator: (value) {
              if (value.trim().isEmpty) return AppStrings.companyBioRequired;
            },
            textCapitalization: TextCapitalization.sentences,
            controller: companyBio,
            decoration: InputDecoration(
                hintText: AppStrings.companyBioHint,
                hintStyle: TextStyle(color: AppColors.hint, fontSize: 16)),
          )
        ],
      ),
    );
  }

  Widget smallCompanyField() {
    return Container(
      margin: EdgeInsets.only(
          top: AppDimens.screenPadding, bottom: AppDimens.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.smallCompany,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Radio(
                  groupValue: _radioValue, value: 0, onChanged: onRadioChanged),
              Text(AppStrings.yes),
              SizedBox(width: 32),
              Radio(
                groupValue: _radioValue,
                value: 1,
                onChanged: onRadioChanged,
              ),
              Text(AppStrings.no),
            ],
          ),
        ],
      ),
    );
  }

  void onRadioChanged(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  Widget nextButton() {
    return Container(
      margin: EdgeInsets.only(left: AppDimens.screenPadding),
      child: InkWell(
        onTap: () {
          if (formKey.currentState.validate()) {
            setState(() {
              submitClicked = true;
            });
            this.bloc.dispatch(
                  CompanyInfoUpdated(
                    this.companyName.text,
                    this.companyBio.text,
                    this._radioValue == 0,
                  ),
                );
            this.bloc.dispatch(SaveButtonTaped(1));
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
            margin: EdgeInsets.only(bottom: 20),
            child: Container(
              padding: EdgeInsets.only(
                  left: AppDimens.buttonPadding,
                  right: AppDimens.buttonPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      AppStrings.saveAndContinue,
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
      ),
    );
  }
}
