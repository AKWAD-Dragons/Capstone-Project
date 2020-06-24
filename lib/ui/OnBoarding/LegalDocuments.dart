import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/PODO/SP.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/resources/strings.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/dimens.dart';
import 'package:flutter/services.dart';
import 'package:sercl/support/router.gr.dart';
import 'ScreenHeader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'FileUploaderWidget.dart';

class LegalDocuments extends StatefulWidget {
  @override
  _LegalDocumentsState createState() => _LegalDocumentsState();
}

class _LegalDocumentsState extends State<LegalDocuments> {
  ProfileBloc profileBloc = GetIt.instance<ProfileBloc>();
  StreamSubscription sub;
  SP sp;

  /* Is false when we first launch the screen, so the screen won't get popped as if we clicked on the save button */
  bool submitClicked = false;

  @override
  void initState() {
    sub = profileBloc.subject.listen((state) {
      if (state is CompanyInfoIs) {
        this.sp = state.sp;
        if (state.sp.documents_status && state.submited && submitClicked) {
          MainRouter.navigator.pop(context);
          Fluttertoast.showToast(
            msg: AppStrings.legalSuccess,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: AppColors.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          return;
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black87));
    return WillPopScope(
      onWillPop: () async {
        if (!submitClicked) {
          profileBloc.dispatch(FilesUpdated(fileName: "", cancel: true));
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ScreenHeader(AppStrings.legalDocuments),
                      SizedBox(
                        height: 16,
                      ),
                      FileUploaderWidget(AppStrings.businessCertificate),
                      FileUploaderWidget(AppStrings.insurance),
                      FileUploaderWidget(AppStrings.contract),
                    ],
                  ),
                ),
              ),
              nextButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget nextButton() {
    return InkWell(
      onTap: () {
        setState(() {
          submitClicked = true;
        });
        profileBloc.dispatch(SaveButtonTaped(5));
      },
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.circular(50)),
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.all(AppDimens.screenPadding),
          child: Container(
            padding: EdgeInsets.only(
                left: AppDimens.buttonPadding, right: AppDimens.buttonPadding),
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
    );
  }
}
