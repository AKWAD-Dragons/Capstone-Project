import 'package:auto_route/auto_route_annotations.dart';
import 'package:sercl/ui/Auth/ForgotPassword.dart';
import 'package:sercl/ui/Auth/LoginScreen.dart';
import 'package:sercl/ui/Auth/ResetPassword.dart';
import 'package:sercl/ui/Auth/SignupScreen.dart';
import 'package:sercl/ui/OnBoarding/AgbRules.dart';
import 'package:sercl/ui/OnBoarding/Areas.dart';
import 'package:sercl/ui/OnBoarding/BillingInfoScreen.dart';
import 'package:sercl/ui/OnBoarding/CompanyInfo.dart';
import 'package:sercl/ui/OnBoarding/LegalDocuments.dart';
import 'package:sercl/ui/OnBoarding/Notes.dart';
import 'package:sercl/ui/OnBoarding/OnBoardingHome.dart';
import 'package:sercl/ui/OnBoarding/Services.dart';
import 'package:sercl/ui/OnBoarding/Settings.dart';
import 'package:sercl/ui/Orders/InvitationOrderDetails.dart';
import 'package:sercl/ui/Orders/OrdersList.dart';
import 'package:sercl/ui/SP_ParentScreen.dart';

import 'package:sercl/ui/SplashScreen.dart';
import 'package:sercl/ui/unknown_screen.dart';

@autoRouter
class $MainRouter {
  LoginScreen login;
  SignupScreen signup;
  ForgotPassword forgotPass;
  ResetPassword resetPass;
  Notes notesScreen;
  CompanyInfo companyInfo;
  Areas areas;
  Services services;
  BillingInfoScreen billingInfoScreen;
  LegalDocuments legalDocuments;
  AgbRules agbRules;
  SP_ParentScreen parent;
  OnBoardingProfile onBoardingProfile;
  InvitationOrderDetails invitationOrderDetails;
  OrderList orders;
  OnBoardingHome onBoardingHome;
  UnknownScreen unknownScreen;

  @initial
  SplashScreen splashScreen;
}
