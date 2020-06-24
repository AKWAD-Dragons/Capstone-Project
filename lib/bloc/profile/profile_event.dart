import 'dart:io';

import 'package:sercl/PODO/Area.dart';
import 'package:sercl/PODO/Service.dart';
import 'package:sercl/PODO/Album.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';

abstract class ProfileEvent {}

/// Used in LogoField widget
/// Pass selected logo to bloc, or pass nothing, to remove the current logo
class LogoImageUpdated extends ProfileEvent {
  File logoImage;

  LogoImageUpdated({this.logoImage});
}

/// Used in CompanyImagesField widget
/// Pass selected images to bloc
class CompanyLogoUpdated extends ProfileEvent {
  File logo;

  CompanyLogoUpdated(this.logo);
}

class CompanyInfoUpdated extends ProfileEvent {
  String name;
  String bio;
  bool isSmallCompany;

  CompanyInfoUpdated(this.name, this.bio, this.isSmallCompany);
}

class CompanyAlbumUpdated extends ProfileEvent {
  List<File> album;

  CompanyAlbumUpdated(this.album);
}

class AreaUpdated extends ProfileEvent {
  Area area;
  bool remove;
  bool cancel;

  AreaUpdated(this.area, this.remove, {this.cancel = false});
}

class SaveButtonTaped extends ProfileEvent {
  int onPage;

  SaveButtonTaped(this.onPage);
}

class OnBoardingScreenLaunched extends ProfileEvent {}

class FilesUpdated extends ProfileEvent {
  File file;
  String fileName;
  String addKey;
  String removeKey;
  bool cancel;

  FilesUpdated(
      {this.fileName,
      this.file,
      this.addKey,
      this.removeKey,
      this.cancel = false});
}

// may be moved to another bloC
class HomePageLaunched extends ProfileEvent {}

class ServicesSelected extends ProfileEvent {
  Service service;
  bool cancel;

  ServicesSelected(this.service, {this.cancel = false});
}

class BillingInfoUpdated extends ProfileEvent {
  String streetName;
  String streetNumber;
  String postalCode;
  String city;
  String phone;
  String iban;
  String bic;
  String taxId;

  BillingInfoUpdated(
    this.streetName,
    this.streetNumber,
    this.postalCode,
    this.city,
    this.phone,
    this.iban,
    this.bic,
    this.taxId,
  );
}

class BillingInfoScreenLaunched extends ProfileEvent {}

class ServiceScreenLaunched extends ProfileEvent {}

class LegalScreenLaunched extends ProfileEvent {}

class SPProfileRequested extends ProfileEvent {}

/// Used in CompanyImagesField widget
/// Pass selected images to bloc
class CompanyImagesUpdated extends ProfileEvent {
  Album companyImages;
  bool remove;

  CompanyImagesUpdated(this.companyImages, {this.remove: false});
}

class ReviewButtonTapped extends ProfileEvent {}

class CompanyPageLaunched extends ProfileEvent {}

class LogoutTapped extends ProfileEvent {}
