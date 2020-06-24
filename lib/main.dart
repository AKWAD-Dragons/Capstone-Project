import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/MyApp.dart';
import 'package:sercl/Utilities/FCMProvider.dart';
import 'package:sercl/bloc/orders/orders_bloc.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/resources/links.dart';
import 'package:sercl/support/Auth/AuthProvider.dart';
import 'package:sercl/support/Fly/fly.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/services/services_bloc.dart';
import 'dialog_provider/dialog_service.dart';

void main() {
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.

  FlutterDownloader.initialize();
  Crashlytics.instance.enableInDevMode = false;

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned(() {
    try {
      runApp(MyApp());
    } catch (e, s) {
      Crashlytics.instance.recordError(e, s, context: 'an example');
    }
  }, onError: Crashlytics.instance.recordError);
}

initData() {
  GetIt.instance.reset();
  String gqLink = AppLinks.protocol +
      AppLinks.subDomain +
      "." +
      AppLinks.apiBaseLink +
      "/graphql";
  GetIt.instance.registerSingleton<Fly<dynamic>>(Fly<dynamic>(gqLink));
  GetIt.instance.registerSingleton<AuthProvider>(AuthProvider());
  GetIt.instance.registerSingleton<DialogService>(DialogService());
  GetIt.instance.registerSingleton<FCMProvider>(FCMProvider());
  GetIt.instance.registerLazySingleton<AuthBloc>(() => AuthBloc());
  GetIt.instance.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
  GetIt.instance.registerLazySingleton<ServicesBloc>(() => ServicesBloc());
//  GetIt.instance.registerSingleton<TechniciansBloc>(TechniciansBloc());
  GetIt.instance.registerSingleton<OrdersBloc>(OrdersBloc());
//  GetIt.instance.registerLazySingleton<VisitsBloc>(() => VisitsBloc());
//  GetIt.instance.registerLazySingleton<ChatBloc>(() => ChatBloc());
//  GetIt.instance.registerLazySingleton<LocationBloc>(() => LocationBloc());
//  GetIt.instance.registerLazySingleton<BillingBloc>(() => BillingBloc());
//  GetIt.instance.registerLazySingleton<ReviewBloc>(() => ReviewBloc());
}

resetGetIt() {
  // GetIt.instance.reset();     /* this line resets all the GetIt instaces */
//  GetIt.instance.resetLazySingleton(instance: GetIt.instance<ServicesBloc>());
  //GetIt.instance.resetLazySingleton(instance: GetIt.instance<AuthProvider>());
  //we do NOT want resrt the DialogService
//  GetIt.instance.resetLazySingleton(instance: GetIt.instance<ProfileBloc>());
//  GetIt.instance.resetLazySingleton(instance: GetIt.instance<ChatBloc>());
  GetIt.instance.resetLazySingleton(instance: GetIt.instance<AuthBloc>());
}
