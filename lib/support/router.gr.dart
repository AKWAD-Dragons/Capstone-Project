// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:sercl/ui/Auth/LoginScreen.dart';
import 'package:sercl/ui/Auth/SignupScreen.dart';
import 'package:sercl/ui/Auth/ForgotPassword.dart';
import 'package:sercl/ui/Auth/ResetPassword.dart';
import 'package:sercl/ui/OnBoarding/Notes.dart';
import 'package:sercl/ui/OnBoarding/CompanyInfo.dart';
import 'package:sercl/ui/OnBoarding/Areas.dart';
import 'package:sercl/ui/OnBoarding/Services.dart';
import 'package:sercl/ui/OnBoarding/BillingInfoScreen.dart';
import 'package:sercl/ui/OnBoarding/LegalDocuments.dart';
import 'package:sercl/ui/OnBoarding/AgbRules.dart';
import 'file:///C:/Users/Bahaa/Desktop/tetst%20app/sercl/lib/ui/SP_ParentScreen.dart';
import 'package:sercl/ui/OnBoarding/Settings.dart';
import 'package:sercl/ui/Orders/InvitationOrderDetails.dart';
import 'package:sercl/ui/Orders/OrdersList.dart';
import 'package:sercl/ui/OnBoarding/OnBoardingHome.dart';
import 'package:sercl/ui/unknown_screen.dart';
import 'package:sercl/ui/SplashScreen.dart';

class MainRouter {
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPass = '/forgot-pass';
  static const resetPass = '/reset-pass';
  static const notesScreen = '/notes-screen';
  static const companyInfo = '/company-info';
  static const areas = '/areas';
  static const services = '/services';
  static const billingInfoScreen = '/billing-info-screen';
  static const legalDocuments = '/legal-documents';
  static const agbRules = '/agb-rules';
  static const parent = '/parent';
  static const onBoardingProfile = '/on-boarding-profile';
  static const invitationOrderDetails = '/invitation-order-details';
  static const orders = '/orders';
  static const onBoardingHome = '/on-boarding-home';
  static const unknownScreen = '/unknown-screen';
  static const splashScreen = '/';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<MainRouter>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case MainRouter.login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case MainRouter.signup:
        return MaterialPageRoute(
          builder: (_) => SignupScreen(),
          settings: settings,
        );
      case MainRouter.forgotPass:
        return MaterialPageRoute(
          builder: (_) => ForgotPassword(),
          settings: settings,
        );
      case MainRouter.resetPass:
        return MaterialPageRoute(
          builder: (_) => ResetPassword(),
          settings: settings,
        );
      case MainRouter.notesScreen:
        return MaterialPageRoute(
          builder: (_) => Notes(),
          settings: settings,
        );
      case MainRouter.companyInfo:
        return MaterialPageRoute(
          builder: (_) => CompanyInfo(),
          settings: settings,
        );
      case MainRouter.areas:
        return MaterialPageRoute(
          builder: (_) => Areas(),
          settings: settings,
        );
      case MainRouter.services:
        return MaterialPageRoute(
          builder: (_) => Services(),
          settings: settings,
        );
      case MainRouter.billingInfoScreen:
        return MaterialPageRoute(
          builder: (_) => BillingInfoScreen(),
          settings: settings,
        );
      case MainRouter.legalDocuments:
        return MaterialPageRoute(
          builder: (_) => LegalDocuments(),
          settings: settings,
        );
      case MainRouter.agbRules:
        return MaterialPageRoute(
          builder: (_) => AgbRules(),
          settings: settings,
        );
      case MainRouter.parent:
        return MaterialPageRoute(
          builder: (_) => SP_ParentScreen(),
          settings: settings,
        );
      case MainRouter.onBoardingProfile:
        return MaterialPageRoute(
          builder: (_) => OnBoardingProfile(),
          settings: settings,
        );
      case MainRouter.invitationOrderDetails:
        if (hasInvalidArgs<String>(args)) {
          return misTypedArgsRoute<String>(args);
        }
        final typedArgs = args as String;
        return MaterialPageRoute(
          builder: (_) => InvitationOrderDetails(),
          settings: settings,
        );
      case MainRouter.orders:
        if (hasInvalidArgs<String>(args)) {
          return misTypedArgsRoute<String>(args);
        }
        final typedArgs = args as String;
        return MaterialPageRoute(
          builder: (_) => OrderList(typedArgs),
          settings: settings,
        );
      case MainRouter.onBoardingHome:
        return MaterialPageRoute(
          builder: (_) => OnBoardingHome(),
          settings: settings,
        );
      case MainRouter.unknownScreen:
        return MaterialPageRoute(
          builder: (_) => UnknownScreen(),
          settings: settings,
        );
      case MainRouter.splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
