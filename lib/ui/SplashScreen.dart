import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/bloc/auth/auth_bloc.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/provider/shared_prefrence_provider.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/support/Auth/AuthProvider.dart';
import 'package:sercl/support/router.gr.dart';


class SplashScreen extends StatefulWidget {
  static String ROUTE = "/";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthBloc _authBloc;
  bool isLogged;
  final AuthProvider provider = GetIt.instance.get();
  ProfileBloc profileBloc = GetIt.instance<ProfileBloc>();
  StreamSubscription sub;

  @override
  void initState() {
    initLocal();
    provider.isUserLoged().then((value) {
      isLogged = value;
      print("The user logged state is $isLogged");
      if (isLogged) {

        profileBloc.dispatch(HomePageLaunched());
        sub = profileBloc.subject.listen((state) {
          if (state is CompanyInfoIs) {
            if (state.sp.verify == false) {
              MainRouter.navigator
                  .pushReplacementNamed(MainRouter.onBoardingHome);
              sub.cancel();
            } else {
              MainRouter.navigator.pushReplacementNamed(MainRouter.parent);
              sub.cancel();
            }
          }
        });


      } else {
        MainRouter.navigator.pushReplacementNamed(MainRouter.login);
      }
    });
    super.initState();
  }

  Future<void> initLocal() async {
    String locale = await SharedPreferencesProvider.instance().getLocale();
    if(locale == null){
      locale = AppStrings.en_code;
    }
    AppStrings.setCurrentLocal(locale);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     precacheImage(AssetImage("assets/images/person.png"), context);
     precacheImage(AssetImage("assets/images/logo.png"), context);
     precacheImage(AssetImage("assets/images/forward.png"), context);
     precacheImage(AssetImage("assets/images/arrow.png"), context);
     precacheImage(AssetImage("assets/images/banner2.png"), context);
     precacheImage(AssetImage("assets/images/hourglass.png"), context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(60),
        child: Center(
          child: Image.asset(
              "assets/images/logo.png"
          ),
        ),
      )
    );
  }
}
