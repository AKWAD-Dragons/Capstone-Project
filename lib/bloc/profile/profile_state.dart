import 'dart:io';

import 'package:sercl/PODO/Area.dart';
import 'package:sercl/PODO/SP.dart';
import 'package:sercl/PODO/Technician.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/support/Auth/User.dart';

abstract class ProfileState {}

class SPProfileIs implements ProfileState {
  bool complete;

  SPProfileIs({this.complete});
}

class UserIs extends ProfileState {
  AuthUser user;

  UserIs(this.user);
}

class SelectedAreasAre extends ProfileState {
  List<Area> selectedAreas;

  SelectedAreasAre(this.selectedAreas);
}

class CompanyInfoIs extends ProfileState {
  SP sp;
  bool submited = false;

  CompanyInfoIs(
    this.submited, {
    this.sp,
  });
}

class SPProfileDataIs extends ProfileState {
  SP sp;

  SPProfileDataIs(this.sp);
}

class WorkerIs extends ProfileState {
  Technician worker;

  WorkerIs(this.worker);
}

class InitialCompanyInfoIs extends ProfileState {
  SP sp;
  bool submited = false;

  InitialCompanyInfoIs(
    this.submited, {
    this.sp,
  });
}

class PageComplete extends ProfileState {
  int page;

  PageComplete(this.page);
}

class LogoutIs extends ProfileState {
  bool success;

  LogoutIs(this.success);
}

class SPBillingInfoIs extends ProfileState {
  String streetName;
  String streetNumber;
  String postalCode;
  String city;
  String phone;
  String iban;
  String bic;
  String taxId;
  bool isSmallCompany;

  SPBillingInfoIs(
    this.streetName,
    this.streetNumber,
    this.postalCode,
    this.city,
    this.phone,
    this.iban,
    this.bic,
    this.taxId,
    this.isSmallCompany,
  );
}
