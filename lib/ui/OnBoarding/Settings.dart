import 'package:flutter/material.dart';
import 'package:sercl/resources/links.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/support/router.gr.dart';
import 'package:sercl/ui/OnBoarding/ChangeLangDialog.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

const String ROUTE = "/onBoardingProfile";

class OnBoardingProfile extends StatefulWidget {
  @override
  _OnBoardingProfileState createState() => _OnBoardingProfileState();
}

class _OnBoardingProfileState extends State<OnBoardingProfile> {
  ProfileBloc bloc = GetIt.instance<ProfileBloc>();
  StreamSubscription subStream;

  @override
  void initState() {
    subStream = GetIt.instance<ProfileBloc>().subject.listen((state) {
      if (state is LogoutIs) {
        MainRouter.navigator
            .pushNamedAndRemoveUntil(MainRouter.splashScreen, (_) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.accentColor,
        title: Text(AppStrings.settings),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(AppDimens.parentContainerRadius),
                topRight: Radius.circular(AppDimens.parentContainerRadius))),
        child: Column(
          children: <Widget>[
            Visibility(
              child: profile(),
              visible: bloc.sp.verify,
            ),
            archive(),
            resetPassword(),
            gotoAdminPanel(),
            changeLang(),
            logout()
          ],
        ),
      ),
    );
  }

  Widget profile() {
    return listItem(
        title: AppStrings.profile,
        trailing: Image.asset(
          "assets/images/profile.png",
          width: 19,
          height: 19,
          color: AppColors.primaryColor,
        ),
        onTap: () {
          MainRouter.navigator.pushNamed(MainRouter.unknownScreen);
        });
  }

  Widget archive() {
    return listItem(
        title: AppStrings.archive,
        trailing: Icon(Icons.archive),
        onTap: () {
          MainRouter.navigator.pushNamed(MainRouter.orders,
              arguments: CodeStrings.mode_archive);
        });
  }

  Widget gotoAdminPanel() {
    return listItem(
        title: AppStrings.adminPanel,
        trailing: Icon(Icons.laptop),
        onTap: () {
          _launchURL(
              "${AppLinks.protocol}${AppLinks.subDomain}.sercl.de/admin");
        });
  }

  Widget resetPassword() {
    return InkWell(
      onTap: () {
        MainRouter.navigator.pushNamed(MainRouter.unknownScreen);
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(AppDimens.screenPadding),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    AppStrings.changePassword,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Image.asset(
                  "assets/images/password.png",
                  width: 20,
                  color: AppColors.primaryColor,
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppColors.lightBackground,
          )
        ],
      ),
    );
  }

  Widget changeLang() {
    return listItem(
      title: AppStrings.changeLang,
      trailing: Icon(Icons.language),
      onTap: () {
        showLangDialog();
      },
    );
  }

  Widget logout() {
    return listItem(
        title: AppStrings.logout,
        trailing: Image.asset(
          "assets/images/logout.png",
          width: 25,
        ),
        onTap: () {
          bloc.dispatch(LogoutTapped());
        });
  }

  showLangDialog() {
    showDialog(context: context, child: ChangeLangDialog());
  }

  Widget listItem(
      {@required String title,
      @required Widget trailing,
      @required Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(AppDimens.screenPadding),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                trailing
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppColors.lightBackground,
          )
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("FAILED TO LAUNCH: $url");
    }
  }
}
