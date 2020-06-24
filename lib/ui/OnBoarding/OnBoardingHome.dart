import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/dimens.dart';
import 'package:sercl/resources/strings.dart';
import 'package:sercl/support/router.gr.dart';
import 'package:sercl/PODO/SP.dart';

const String ROUTE = "/OnBoardingHome";

class OnBoardingHome extends StatefulWidget {
  @override
  _OnBoardingHomeState createState() => _OnBoardingHomeState();
}

class _OnBoardingHomeState extends State<OnBoardingHome> {
  SP sp;
  StreamSubscription subStream;
  ProfileBloc bloc = GetIt.instance<ProfileBloc>();

  Map<String, Color> colors = {
    "company-info": AppColors.yellow,
    "areas": AppColors.yellow,
    "services": AppColors.yellow,
    "legal-docs": AppColors.yellow
  };

  /* Show loading on refresh button if true, show arrow if false */
  bool refreshing = false;
  bool showPending = false;
  bool canSubmit = false;
  bool agbAgreed = false, showAgreeError = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    bloc.dispatch(OnBoardingScreenLaunched());

    subStream = GetIt.instance<ProfileBloc>().subject.listen((state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (state is CompanyInfoIs) {
          setState(() {
            sp = state.sp;
            refreshing = false;
            if (sp != null) {
              updateCanSubmit();
              if (sp.verify) {
                MainRouter.navigator.pushReplacementNamed(MainRouter.parent);
                subStream.cancel();
              } else if (sp.ready_for_verify) {
                showPending = true;
              } else {
                showPending = false;
              }
            }
          });
        }
      });
    });
  }

  void updateCanSubmit() {
    setState(() {
      canSubmit = sp.info_status && sp.areas_status && sp.services_status;
    });
  }

  @override
  void dispose() {
    subStream.cancel();
    subStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: sp == null
          ? Container()
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          MainRouter.navigator
                              .pushNamed(MainRouter.onBoardingProfile);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  topLeft: Radius.circular(50))),
                          width: 80,
                          height: 60,
                          padding:
                              EdgeInsets.only(top: 15, bottom: 15, left: 5),
                          child: Image.asset(
                            "assets/images/person.png",
                            color: AppColors.white,
                            width: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: AppDimens.screenPadding,
                              right: AppDimens.screenPadding,
                              top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/logo.png",
                                width: 180,
                              ),
                              SizedBox(height: 10),
                              Text(
                                AppStrings.forServiceProviders,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: !showPending,
                    child: sections(),
                  ),
                  Visibility(
                    visible: showPending,
                    child: pendingView(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget sections() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: bloc.sp.notes.length > 0,
            child: InkWell(
              onTap: () {
                MainRouter.navigator.pushNamed(MainRouter.notesScreen);
              },
              child: notesBanner(),
            ),
          ),
          singleProfileItem(
              AppStrings.companyInfo,
              AppStrings.nameLogoBio,
              MainRouter.companyInfo,
              sp.info_status ?? false ? AppColors.green : AppColors.yellow),
          SizedBox(height: 10),
          singleProfileItem(
              AppStrings.areas,
              AppStrings.areasSub,
              MainRouter.areas,
              sp.areas_status ? AppColors.green : AppColors.yellow),
          SizedBox(height: 10),
          singleProfileItem(
              AppStrings.services,
              AppStrings.servicesSub,
              MainRouter.services,
              sp.services_status ? AppColors.green : AppColors.yellow),
          SizedBox(height: 10),
          singleProfileItem(
              AppStrings.billingInfoTitle,
              AppStrings.billingInfoSubtitle,
              MainRouter.billingInfoScreen,
              sp.billing_status ? AppColors.green : AppColors.yellow),
          SizedBox(height: 10),
          singleProfileItem(
              AppStrings.legalDocuments,
              AppStrings.legalDocumentsSub,
              MainRouter.legalDocuments,
              AppColors.gray),
          SizedBox(
            height: 4,
          ),
          checkBox(),
          checkBoxError(),
          Container(
              margin: EdgeInsets.only(left: AppDimens.screenPadding),
              child: Visibility(
                child: nextButton(),
                visible: (sp != null && !sp.ready_for_verify),
              )),
        ],
      ),
    );
  }

  Widget checkBox() {
    return Container(
        margin: EdgeInsets.only(left: 8, right: AppDimens.screenPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Checkbox(
              value: agbAgreed,
              onChanged: (value) {
                setState(() {
                  agbAgreed = value;
                });
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5, top: 15, bottom: 15,),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: AppColors.primaryColor
                        ),
                        children: <TextSpan>[
                          TextSpan(text: AppStrings.acceptRules1),
                          TextSpan(
                              text: AppStrings.terms,

                              style: TextStyle(
                                color: AppColors.accentColor,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  MainRouter.navigator.pushNamed(MainRouter.agbRules);
                                }),
                          TextSpan(text: AppStrings.acceptRules2),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget checkBoxError() {
    return Visibility(
      visible: showAgreeError,
      child: Container(
        padding: EdgeInsets.only(
          left: AppDimens.screenPadding,
          right: AppDimens.screenPadding,
          bottom: 8,
        ),
        child: Text(
          AppStrings.agreeError,
          style: TextStyle(color: AppColors.errorColor),
        ),
      ),
    );
  }

  Widget logout() {
    return FlatButton(
        onPressed: () {},
        child: Text(
          AppStrings.logout,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ));
  }

  Widget nextButton() {
    return InkWell(
      onTap: canSubmit
          ? () {
              if (!agbAgreed) {
                setState(() {
                  showAgreeError = true;
                });
                return;
              } else {
                setState(() {
                  showAgreeError = false;
                });
              }
              bloc.dispatch(ReviewButtonTapped());
            }
          : null,
      child: Container(
          decoration: BoxDecoration(
              color: canSubmit ? AppColors.accentColor : AppColors.gray,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50))),
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.only(bottom: 20),
          child: Container(
            padding: EdgeInsets.only(
                left: AppDimens.buttonPadding, right: AppDimens.buttonPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    AppStrings.submitForReview,
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

  Widget notesBanner() {
    return Container(
      margin: EdgeInsets.only(right: 30, bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.errorColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50))),
      width: double.infinity,
      padding: EdgeInsets.all(AppDimens.screenPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.error,
            color: AppColors.white,
            size: 50,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  child: Text(
                    AppStrings.gotNotes,
                    style: TextStyle(fontSize: 16, color: AppColors.white),
                  ),
                  alignment: AlignmentDirectional.topStart,
                ),
                SizedBox(height: 5),
                Align(
                  child: Text(
                    AppStrings.viewNotes,
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  alignment: AlignmentDirectional.topStart,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget singleProfileItem(
      String title, String subtitle, String route, Color color) {
    return InkWell(
      onTap: () {
        if (!sp.ready_for_verify ?? false) {
          navigate(route);
        }
      },
      child: Container(
        height: 90,
        child: Row(
          children: <Widget>[
            Container(width: 8, color: color, height: 90),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.lightBackground,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                margin: EdgeInsets.only(right: 30),
                padding: EdgeInsets.only(
                    left: AppDimens.screenPadding,
                    right: AppDimens.screenPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Text(
                            subtitle,
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/images/arrow.png",
                      width: 24,
                      height: 24,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pendingView() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      color: AppColors.lightBackground,
      padding: EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/hourglass.png",
              width: 60,
            ),
            SizedBox(height: 30),
            Text(
              AppStrings.pending,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.primaryColor),
            ),
            SizedBox(height: 10),
            Text(
              AppStrings.pleaseWait,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.primaryColor),
            ),
            refreshButton()
          ],
        ),
      ),
    );
  }

  Widget refreshButton() {
    return InkWell(
      onTap: () {
        setState(() {
          refreshing = true;
        });
        bloc.dispatch(OnBoardingScreenLaunched());
      },
      child: Container(
          padding: EdgeInsets.only(
              left: AppDimens.buttonPadding, right: AppDimens.buttonPadding),
          decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.only(top: 30, bottom: 10),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    AppStrings.refresh,
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                refreshing
                    ? CircularProgressIndicator(
                        backgroundColor: AppColors.white,
                      )
                    : Image.asset(
                        "assets/images/forward.png",
                        width: 20,
                        height: 20,
                      ),
              ],
            ),
          )),
    );
  }

  Widget notesButton() {
    return FlatButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.red)),
      color: Colors.red,
      textColor: Colors.white,
      padding: EdgeInsets.all(8.0),
      onPressed: () {
        MainRouter.navigator.pushNamed(MainRouter.notesScreen);
      },
      child: Text(
        AppStrings.notes,
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
    );
  }

  void navigate(String route) async {
    MainRouter.navigator.pushNamed(route);
    // init();
  }
}
