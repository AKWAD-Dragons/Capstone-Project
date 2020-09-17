import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:load/load.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sercl/PODO/Day.dart';
import 'package:sercl/PODO/Note.dart';
import 'package:sercl/PODO/SP.dart';
import 'package:sercl/PODO/Service.dart';
import 'package:sercl/PODO/Technician.dart';
import 'package:sercl/PODO/Album.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/dialog_provider/dialog_models.dart';
import 'package:sercl/dialog_provider/dialog_service.dart';
import 'package:sercl/main.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/services/ProfileService.dart';
import 'package:sercl/support/Auth/AppException.dart';
import 'package:sercl/support/Auth/AuthProvider.dart';
import 'package:sercl/support/Fly/fly.dart';
import 'package:sercl/support/GraphClient/GraphQLBuilder.dart';
import 'package:sercl/support/router.gr.dart';

import '../bloc.dart';

class ProfileBloc extends BLoC<ProfileEvent> {
  BehaviorSubject<ProfileState> subject = BehaviorSubject();
  DialogService _dialogService = GetIt.instance<DialogService>();
  final AuthProvider provider = GetIt.instance.get();
  ProfileService _profileService = GetIt.instance<ProfileService>();

  SP sp;
  Technician tech;

  //we need this so that user can cancel removing docs;
  Map<String, CustomFile> nonSubmittedRemovedDocs = {};

  ProfileBloc() {
    sp = SP.empty();
  }

  List<Service> get disConnectedServices {
    List<Service> result = List();
    this.sp.services.forEach((service) {
      if (!this.sp.selectedServices.contains(service)) {
        result.add(service);
      }
    });

    return result;
  }

  @override
  void dispatch(ProfileEvent event) {
    if (event is HomePageLaunched) {
      homePageLaunched().catchError((e) async {
        hideLoadingDialog();
        if (e is AppException) {
          if (e.name == "WorkerNotFound") {
            logout();
          }
          await _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
          if (e.name == "UserRoleInvalid") {
            logout();
          }
        } else {
          _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
        }
      });
    }
    if (event is LogoutTapped) {
      logout().catchError((onError) {
        if (onError is AppException)
          _dialogService.showDialog(ErrorDialog(message: onError.beautifulMsg));
        else {
          _dialogService
              .showDialog(ErrorDialog(message: AppStrings.errorOccured));
        }
      });
    }
    if (event is ReviewButtonTapped) {
      submitCompanyForReview(event).catchError((e) {
        hideLoadingDialog();
        if (e is AppException)
          _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
        else {
          _dialogService
              .showDialog(ErrorDialog(message: AppStrings.errorOccured));
        }
      });
    }

    if (event is CompanyLogoUpdated) {
      updateCompanyLogo(event.logo).catchError((e) {
        if (e is AppException) {
          _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
        } else {
          _dialogService
              .showDialog(ErrorDialog(message: AppStrings.errorOccured));
        }
      });
    }

    if (event is CompanyInfoUpdated) {
      updateCompanyInfo(event).catchError((e) {
        if (e is AppException) {
          _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
        } else {
          _dialogService
              .showDialog(ErrorDialog(message: AppStrings.errorOccured));
        }
      });
    }

    if (event is AreaUpdated) {
      updateArea(event).catchError((e) {
        if (e is AppException) {
          _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
        } else {
          _dialogService
              .showDialog(ErrorDialog(message: AppStrings.errorOccured));
        }
      });
    }

    if (event is ServicesSelected) {
      updateServices(event).catchError((e) {
        if (e is AppException) {
          _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
        } else {
          _dialogService
              .showDialog(ErrorDialog(message: AppStrings.errorOccured));
        }
      });
    }

    if (event is ServiceScreenLaunched) {
      this.subject.add(CompanyInfoIs(false, sp: this.sp));
    }

    if (event is LegalScreenLaunched) {
      this.subject.add(CompanyInfoIs(false, sp: this.sp));
    }
    if (event is SPProfileRequested) {
      this.subject.add(SPProfileDataIs(this.sp));
    }

    if (event is OnBoardingScreenLaunched) {
      checkSPValid().catchError((e) {
        if (e is AppException) {
          _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
        } else {
          _dialogService
              .showDialog(ErrorDialog(message: AppStrings.errorOccured));
        }
      });
    }

    if (event is CompanyImagesUpdated) {
      this.updateAlbum(event);
    }
    if (event is FilesUpdated) {
      if (event.cancel) {
        nonSubmittedRemovedDocs.forEach((String key, CustomFile val) {
          if (key == AppStrings.businessCertificate) {
            this.sp.businessCertAsFile = val;
          } else if (key == AppStrings.insurance) {
            this.sp.insuranceAsFile = val;
          } else if (key == AppStrings.contract) {
            this.sp.contractAsFile = val;
          }
        });
        nonSubmittedRemovedDocs = {};
        return;
      }
      if (event.addKey == AppStrings.businessCertificate) {
        this.sp.businessCertAsFile = CustomFile(event.fileName, event.file);
      } else if (event.addKey == AppStrings.insurance) {
        this.sp.insuranceAsFile = CustomFile(event.fileName, event.file);
      } else if (event.addKey == AppStrings.contract) {
        this.sp.contractAsFile = CustomFile(event.fileName, event.file);
      }

      if (event.removeKey == AppStrings.businessCertificate) {
        if (this.sp.business_certificate != null) {
          //this doc is submitted before
          nonSubmittedRemovedDocs[event.removeKey] = this.sp.businessCertFile;
        }
        this.sp.businessCertAsFile = null;
      } else if (event.removeKey == AppStrings.insurance) {
        if (this.sp.insurance != null) {
          //this doc is submitted before
          nonSubmittedRemovedDocs[event.removeKey] = this.sp.insuranceFile;
        }
        this.sp.insuranceAsFile = null;
      } else if (event.removeKey == AppStrings.contract) {
        if (this.sp.contract != null) {
          //this doc is submitted before
          nonSubmittedRemovedDocs[event.removeKey] = this.sp.contractFile;
        }
        this.sp.contractAsFile = null;
      }
      this.subject.add(CompanyInfoIs(false, sp: this.sp));
    }

    if (event is SaveButtonTaped) {
      switch (event.onPage) {
        case 1:
          saveCompanyInfo(event).catchError((e) async {
            hideLoadingDialog();
            if (e is AppException) {
              _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
            } else {
              _dialogService
                  .showDialog(ErrorDialog(message: AppStrings.errorOccured));
            }
          });
          break;
        case 2:
          saveCompanyAreas(event).catchError((e) {
            hideLoadingDialog();
            if (e is AppException) {
              _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
            } else {
              _dialogService
                  .showDialog(ErrorDialog(message: AppStrings.errorOccured));
            }
          });
          break;
        case 3:
          saveCompanyServices(event).catchError((e) {
            hideLoadingDialog();
            if (e is AppException) {
              _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
            } else {
              _dialogService
                  .showDialog(ErrorDialog(message: AppStrings.errorOccured));
            }
          });
          break;
        case 4:
          saveBillingInfo(event).catchError((e) {
            hideLoadingDialog();
            if (e is AppException) {
              _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
            } else {
              _dialogService.showDialog(ErrorDialog(message: e.toString()));
            }
          });
          break;
        case 5:
          saveCompanyFiles(event).catchError((e) {
            hideLoadingDialog();
            if (e is AppException) {
              _dialogService.showDialog(ErrorDialog(message: e.beautifulMsg));
            } else {
              _dialogService.showDialog(ErrorDialog(message: e.toString()));
            }
          });
          break;
      }
    }

    if (event is CompanyPageLaunched) {
      print(
          "SP LOGO FROM BLOC IN SCREEN LANUCHED : " + this.sp.logo.toString());
      this.subject.add(CompanyInfoIs(false, sp: this.sp));
    }

    if (event is BillingInfoScreenLaunched) {
      getSPBillingInfo();
    }

    if (event is BillingInfoUpdated) {
      addBillingInfoToSP(event);
    }
  }

  Future<void> checkSPValid() async {
    await updateSP();
    if (sp.notes != null && sp.notes.length > 0) {
      String notes = "";
      sp.notes.forEach((Note n) => notes += "\n${n.description}");
      // _dialogService.showDialog(ErrorDialog(title: AppStrings.notes,message: notes));
    }
    this.subject.add(CompanyInfoIs(false, sp: this.sp));
  }

  Future<void> updateAlbum(CompanyImagesUpdated event) async {
    if (this.sp.images == null) this.sp.images = List<File>();
    if (sp.selectedAlbums == null) sp.selectedAlbums = [];
    if (sp.deletedAlbums == null) sp.deletedAlbums = [];
    if (event.remove) {
      //
      if (sp.albums.contains(event.companyImages)) {
        sp.albums.remove(event.companyImages);
        if (event.companyImages.id != null) {
          sp.deletedAlbums.add(event.companyImages);
        }
        sp.selectedAlbums.remove(event.companyImages);
        print(sp.deletedAlbums.length);
      } else {
        sp.albums.remove(event.companyImages);
        sp.deletedAreas.remove(event.companyImages);
        sp.selectedAlbums.remove(event.companyImages);
        print(sp.deletedAlbums.length);
      }
    } else {
      sp.albums.add(event.companyImages);
      sp.selectedAlbums.add(event.companyImages);
    }

    this.subject.add(CompanyInfoIs(false, sp: this.sp));
  }

  void getSPBillingInfo() async {
    showLoadingDialog();

    Map mySP = await _profileService.getSPBillingInfo();
    this.sp
      ..billing_status = mySP["mySP"].billing_status
      ..streetName = mySP["mySP"].streetName
      ..streetNumber = mySP["mySP"].streetNumber
      ..phone = mySP["mySP"].phone
      ..postalCode = mySP["mySP"].postalCode
      ..city = mySP["mySP"].city
      ..iban = mySP["mySP"].iban
      ..small_company = mySP["mySP"].small_company
      ..taxId = mySP["mySP"].taxId
      ..bic = mySP["mySP"].bic;
    hideLoadingDialog();

    subject.add(SPBillingInfoIs(
        this.sp.streetName,
        this.sp.streetNumber,
        this.sp.postalCode,
        this.sp.city,
        this.sp.phone,
        this.sp.iban,
        this.sp.bic,
        this.sp.taxId,
        this.sp.small_company));
  }

  void addBillingInfoToSP(BillingInfoUpdated event) async {
    if (event.streetName != null) {
      this.sp.streetName = event.streetName;
    }
    if (event.streetNumber != null) {
      this.sp.streetNumber = event.streetNumber;
    }
    if (event.postalCode != null) {
      this.sp.postalCode = event.postalCode;
    }
    if (event.city != null) {
      this.sp.city = event.city;
    }
    if (event.phone != null) {
      this.sp.phone = event.phone;
    }
    if (event.iban != null) {
      this.sp.iban = event.iban;
    }
    if (event.bic != null) {
      this.sp.bic = event.bic;
    }

    if (sp.small_company ||
        (!sp.small_company &&
            event.taxId != null &&
            event.taxId.trim().isNotEmpty)) {
      this.sp.taxId = event.taxId;
    }
  }

  Future<void> saveBillingInfo(SaveButtonTaped event) async {
    showLoadingDialog();

    Map<String, dynamic> argMap = {
      'id': sp.id,
      'billing_status': true,
      'street_name': sp.streetName,
      'street_number': sp.streetNumber.toString(),
      'phone': sp.phone,
      'postal_code': sp.postalCode.toString(),
      'city': sp.city,
      'iban': sp.iban.toString(),
      'bic': sp.bic.toString(),
      'tax_id': sp.taxId.isEmpty ? null : sp.taxId
    };

    Map mySP = await _profileService.saveBillingInfo(argMap);
    this.sp
      ..billing_status = mySP["updateSP"].billing_status
      ..info_status = mySP["updateSP"].info_status
      ..streetName = mySP["updateSP"].streetName
      ..streetNumber = mySP["updateSP"].streetNumber
      ..phone = mySP["updateSP"].phone
      ..postalCode = mySP["updateSP"].postalCode
      ..city = mySP["updateSP"].city
      ..iban = mySP["updateSP"].iban
      ..bic = mySP["updateSP"].bic;

    hideLoadingDialog();
    MainRouter.navigator.pop();
    subject.add(CompanyInfoIs(true, sp: sp));
  }

  Future<void> saveCompanyFiles(SaveButtonTaped event) async {
    if (this.sp.insuranceFile != null) {
      this.sp.insurance = this.sp.insuranceFile.base64;
    }
    if (this.sp.businessCertFile != null) {
      this.sp.business_certificate = this.sp.businessCertFile.base64;
    }
    if (this.sp.contractFile != null) {
      this.sp.contract = this.sp.contractFile.base64;
    }
    showLoadingDialog(tapDismiss: false);

    Map updatedSP = await _profileService.saveCompanyFiles(sp);
    hideLoadingDialog();
    if (updatedSP['updateSP'].documents_status != "completed") {
//      AppException(false,
//          name: "SPDataMissingAfterUpdate",
//          beautifulMsg:
//              "For some reason update didn't return the updated data",
//          uglyMsg: "Beauty is a perception");
    }

    this.sp = updatedSP['updateSP'];

    this.subject.add(CompanyInfoIs(true, sp: this.sp));
  }

  Future<void> updateServices(ServicesSelected event) async {
    if (event.cancel) {
      sp.deSelectedServices = [];
      sp.selectedServices = [];
      this.subject.add(CompanyInfoIs(false, sp: this.sp));
      return;
    }
    if (sp.services.contains(event.service)) {
      if (sp.deSelectedServices.contains(event.service)) {
        sp.deSelectedServices.remove(event.service);
      } else
        sp.deSelectedServices.add(event.service);
    } else if (sp.selectedServices.contains(event.service)) {
      sp.selectedServices.remove(event.service);
    } else {
      sp.selectedServices.add(event.service);
    }

    this.subject.add(CompanyInfoIs(false, sp: this.sp));
  }

  Future<void> updateArea(AreaUpdated event) async {
    if (event.cancel) {
      sp.addedAreas = [];
      sp.deletedAreas = [];
      return;
    }
    if (event.remove) {
      if (sp.areas.contains(event.area)) {
        sp.deletedAreas.add(event.area);
      } else {
        sp.addedAreas.remove(event.area);
      }
    } else {
      sp.addedAreas.add(event.area);
    }

    this.subject.add(CompanyInfoIs(false, sp: this.sp));
  }

  Future<List<Album>> convertFilesToAlbums(List<File> files) async {
    List<Album> albums = List();
    for (int i = 0; i < files.length; i++) {
      final result = base64Encode(await files[i].readAsBytes());
      Album album = Album(image_link: result);
      albums.add(album);
    }
    return albums;
  }

  Future logout() async {
    await provider.logout();
    resetGetIt();
    subject.add(LogoutIs(true));
  }

  Future<void> saveCompanyInfo(SaveButtonTaped event) async {
    showLoadingDialog(tapDismiss: false);
    String photo;
    List<Album> albums = List();
    if (this.sp.logo != null) {
      photo = base64Encode(await this.sp.logo.readAsBytes());
    }
    // if (sp.images != null) {
    //   albums = await convertFilesToAlbums(sp.images);
    // }
    Map<String, dynamic> args;
    args = {
      "id": int.parse(this.sp.id),
      "name": sp.name,
      "bio": sp.bio.replaceAll('\n', ' '),
      "small_company": sp.small_company,
      "info_status": true,
    };
    if (!sp.small_company && (sp.taxId == null || sp.taxId.trim().isEmpty)) {
      args['billing_status'] = false;
    }
    if (photo != null) {
      args["logo_link"] = photo;
    } else {
      if (sp.logo_link == null || sp.logo_link == "") {
        args["logo_link"] = null;
      }
    }

    Map<String, dynamic> albumMap = {};

    if (sp.selectedAlbums != null && sp.selectedAlbums.isNotEmpty) {
      List<Map<String, String>> createList = List();

      sp.selectedAlbums.forEach((Album album) {
        createList.add({"image_link": album.image_link.toString()});
        print(createList.toString());
      });

      //print(createList.toString());

      albumMap["create"] = createList;

//      args["input"] = {
//        "albums": {
//          "create": createList,
//        }
//      };
    }
    if (sp.deletedAlbums != null && sp.deletedAlbums.isNotEmpty) {
      List<int> deleteList = List();
      sp.deletedAlbums.forEach((Album album) {
        deleteList.add(int.parse(album.id));
        print(deleteList.toString());
      });

      albumMap["delete"] = deleteList;
//      args["input"] = {
//        "albums": {
//          "delete": deleteList,
//        }
//      };
    }

    if (albumMap.isNotEmpty) {
      args["input"] = {"albums": albumMap};
    }

    Map updatedSP = await _profileService.saveCompanyInfo(args);
    this.sp = updatedSP['updateSP'];
    if (updatedSP['updateSP'].info_status == null ||
        updatedSP['updateSP'].info_status == false) {
//      throw AppException(false,
//          name: "SPDataMissingAfterUpdate",
//          beautifulMsg: "For some reason update didn't return the updated data",
//          uglyMsg: "Beauty is a perception");
    }
    hideLoadingDialog();

    // all is good go to page 2
    this.subject.add(CompanyInfoIs(true, sp: sp));
  }

  Future<void> saveCompanyAreas(SaveButtonTaped event) async {
    showLoadingDialog(tapDismiss: false);
    SP sp = this.sp;

    ///THIS PART IS ALSO IN AREAS SCREEN => NEXT BUTTON AND SHOULD BE PUT IN ONE PLACE
    int areasSum = sp.areas == null ? 0 : sp.areas.length;
    int addedSum = sp.addedAreas == null ? 0 : sp.addedAreas.length;
    int deletedSum = sp.deletedAreas == null ? 0 : sp.deletedAreas.length;
    bool areasStatus = areasSum + addedSum - deletedSum != 0;

    Map updatedSP = await _profileService.saveCompanyAreas(sp, areasStatus);
    hideLoadingDialog();
    if (updatedSP['updateSP'].areas_status != true) {
//      AppException(false,
//          name: "SPDataMissingAfterUpdate",
//          beautifulMsg:
//              "For some reason update didn't return a the updated data",
//          uglyMsg: "Beauty is a perception");
    }

    this.sp = updatedSP['updateSP'];

    this.subject.add(CompanyInfoIs(true, sp: this.sp));
  }

  Set<String> buildConCats() {
    Set<String> addedCats = Set();
    for (Service service in sp.selectedServices) {
      bool found = false;
      for (Service cService in sp.services) {
        if (cService.category.id == service.category.id &&
            cService.id != service.id) {
          found = true;
          break;
        }
      }
      if (!found) {
        addedCats.add(service.category.id);
      }
    }
    return addedCats;
  }

  Set<String> buildDisConCats() {
    Set<String> deletedCat = Set();
    for (Service service in sp.deSelectedServices) {
      bool found = false;
      for (Service cService in sp.services) {
        if (cService.category.id == service.category.id &&
            cService.id != service.id &&
            sp.deSelectedServices.contains(cService) == false) {
          found = true;
          break;
        }
      }
      if (!found) {
        deletedCat.add(service.category.id);
      }
    }
    return deletedCat;
  }

  Future<void> saveCompanyServices(SaveButtonTaped event) async {
    showLoadingDialog(tapDismiss: false);

    ///THIS PART IS ALSO IN SERVICES SCREEN => NEXT BUTTON AND SHOULD BE PUT IN ONE PLACE
    int servicesSum = sp.services == null ? 0 : sp.services.length;
    int selectedSum =
        sp.selectedServices == null ? 0 : sp.selectedServices.length;
    int deSeletedSum =
        sp.deSelectedServices == null ? 0 : sp.deSelectedServices.length;
    bool servicesState = (servicesSum + selectedSum - deSeletedSum) > 0;
    Set<String> conCats = buildConCats();
    Set<String> disConCats = buildDisConCats();
    // update the SP state

    Map resluts = await _profileService.saveCompanyServices(
        conCats, disConCats, sp, servicesState);
    hideLoadingDialog();
    if (resluts['updateSP'].services_status != true) {
//      AppException(false,
//          name: "SPDataMissingAfterUpdate",
//          beautifulMsg:
//              "For some reason update didn't return a the updated data",
//          uglyMsg: "Beauty is a perception");
    }

    this.sp = resluts['updateSP'];

    this.subject.add(CompanyInfoIs(true, sp: this.sp));
  }

  Future<void> updateCompanyInfo(CompanyInfoUpdated event) async {
    this.sp.name = event.name;
    this.sp.bio = event.bio;
    this.sp.small_company = event.isSmallCompany;

    subject.add(CompanyInfoIs(false, sp: this.sp));
  }

  Future<void> updateCompanyLogo(File logo) async {
    if (logo != null && logo.existsSync()) {
      this.sp.logo = logo;
    } else {
      this.sp.logo = null;
      this.sp.logo_link = null;
    }

    subject.add(CompanyInfoIs(false, sp: this.sp));
  }

  Future<void> submitCompanyForReview(ReviewButtonTapped event) async {
    nonSubmittedRemovedDocs = {};
    showLoadingDialog(tapDismiss: false);
    print(this.sp.id);

    dynamic updatedSP = await _profileService.submitCompanyForReview(sp);
    this.sp = updatedSP['updateSP'];
    hideLoadingDialog();
    if (updatedSP['updateSP'].ready_for_verify == null) {
//      throw AppException(false,
//          name: "SPDataMissingAfterUpdate",
//          beautifulMsg:
//              "For some reason update didn't return a the updated data",
//          uglyMsg: "Beauty is a perception");
    }

    // all is good go to page 2
    this.subject.add(CompanyInfoIs(true, sp: sp));
  }

  Future<void> homePageLaunched() async {
    // get the authed user
    bool logged = await provider.isUserLoged();
    print("Logged state is $logged");

    if (!logged) {
      subject.add(UserIs(null));
      return;
    }

    //query to get the sp
    //showLoadingDialog();

    Map result = await _profileService.homePageLaunched(provider.user.role);

    if (provider.user.role == CodeStrings.sp) {
      if (result["mySP"] == null) {
        this.sp = SP.empty();
        await createSP();
        //hideLoadingDialog();
        subject.add(CompanyInfoIs(false, sp: this.sp));
        return;
      }
      this.sp = result['mySP'];
      this.tech = result['mySP'].worker;
      //hideLoadingDialog();
      subject.add(CompanyInfoIs(false, sp: this.sp));
    } else if (provider.user.role == CodeStrings.worker) {
      if (result["myWorker"] != null) {
        this.tech = result["myWorker"];
        subject.add(WorkerIs(this.tech));
        return;
      }
      throw AppException(false,
          name: "WorkerNotFound", beautifulMsg: AppStrings.profileNotFound);
    }
  }

  Future<void> updateSP() async {
    Map result = await _profileService.updateSP();
    this.sp = result['mySP'];
  }

  Future createSP() async {
    Map result = await _profileService.createSP(provider.user.id);
    if (result["createSP"].id == null) {
//      throw AppException(false,
//          name: "SpIDMissing",
//          beautifulMsg:
//              "For some reason create SP didn't return a id can't continue without it",
//          uglyMsg: "Try to find the beuty in every ugly");
    }

    this.sp = result["createSP"];
    // hideLoadingDialog();
  }
}
