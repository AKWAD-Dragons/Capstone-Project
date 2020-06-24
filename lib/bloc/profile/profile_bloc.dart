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

  SP sp;
  Technician tech;

  //we need this so that user can cancel removing docs;
  Map<String, CustomFile> nonSubmittedRemovedDocs = {};

  Fly fly;

  static Node orderNode = Node(name: "order", cols: [
    "id",
    "customer_name",
    Node(name: "service", cols: [
      "id",
      "name",
    ]),
    Node(name: "category", cols: [
      "id",
      "name",
      "icon",
      "color",
    ]),
    Node(
      name: 'invitation',
      cols: [
        'id',
        'price',
        Node(
          name: "order",
          args: {},
          cols: [
            Node(
              name: "serviceProvider",
              args: {},
              cols: ['id'],
            ),
          ],
        ),
      ],
    ),
    "description",
    "record",
    "receipt",
    "status",
    "customer_name",
    "street_name",
    "street_no",
    "postcode",
    "phone",
    "email",
    Node(name: "videos", cols: [
      "id",
      "video_link",
    ]),
    Node(name: "albums", cols: [
      "id",
      "image_link",
    ])
  ]);

  static Node invitationsNode = Node(
    name: "invitations",
    args: {},
    cols: [
      "id",
      "status",
      "price",
      "chat_room",
      Node(
        name: "order",
        args: {},
        cols: [
          Node(
            name: "serviceProvider",
            args: {},
            cols: ['id'],
          ),
        ],
      ),
      Node(
        name: "request",
        cols: [
          "id",
          "description",
          "created_at",
          "record",
          "status",
          Node(name: "category", cols: [
            "id",
            "name",
            "icon",
            "color",
          ]),
          Node(name: "customer", cols: [
            "id",
            "name",
          ]),
          Node(
            name: "service",
            cols: [
              "id",
              "name",
            ],
          ),
          Node(
            name: "address",
            cols: ["id", "street_name", "street_number", "postal_code"],
          ),
          Node(
            name: "albums",
            cols: [
              "id",
              "image_link",
            ],
          ),
          Node(
            name: "videos",
            cols: [
              "id",
              "video_link",
            ],
          )
        ],
      )
    ],
  );

  List<dynamic> spCols = [
    'id',
    Node(name: "orders", args: {}, cols: [
      'id',
      'status',
      'customer_name',
      'email',
      'street_no',
      'street_name',
      'phone',
      "receipt",
      'description',
      'postcode',
      Node(name: "service", cols: [
        'id',
        'name',
        Node(name: "category", cols: [
          "id",
        ]),
      ]),
      Node(name: "category", cols: ['id', 'name', 'icon', 'color']),
      Node(name: "albums", cols: [
        'id',
        'image_link',
      ]),
    ]),
    Node(name: "ratings", cols: [
      "id",
      "rating",
      "price_rating",
      "comment",
      "created_at",
      orderNode,
    ]),
    invitationsNode,
    workerNode,
    'name',
    'bio',
    'logo_link',
    'business_certificate',
    'insurance',
    'contract',
    'verify',
    'ready_for_verify',
    'services_status',
    'areas_status',
    'info_status',
    'documents_status',
    'billing_status',
    'avg_price',
    'avg_rating',
    'small_company',
    Node(name: 'workers', cols: [
      'id',
      'name',
      "email",
      "custom_schedule",
      Node(name: "schedules", cols: [
        "id",
        "day",
        "from",
        "to",
      ]),
      Node(name: 'authUser', cols: ['id', 'email', 'role', 'first_logged']),
    ]),
    Node(name: 'areas', cols: ['id', 'to', 'from']),
    Node(name: 'services', cols: [
      'name',
      'id',
      Node(name: "category", cols: [
        "id",
      ]),
    ]),
    Node(name: 'albums', cols: ['id', 'image_link']),
    Node(name: 'notes', cols: ['id', 'description', 'created_at', 'section']),
    Node(name: 'authUser', cols: ['id', 'email', 'role', 'first_logged']),
  ];

  static Node workerNode = Node(name: "worker", cols: [
    'id',
    'name',
    "email",
    "custom_schedule",
    Node(name: "schedules", cols: [
      "id",
      "day",
      "from",
      "to",
    ]),
    Node(name: 'authUser', cols: ['id', 'email', 'role', 'first_logged']),
  ]);

  List<dynamic> workerCols = [
    'id',
    'name',
    "email",
    "custom_schedule",
    Node(name: "schedules", cols: [
      "id",
      "day",
      "from",
      "to",
    ]),
    Node(name: 'authUser', cols: ['id', 'email', 'role', 'first_logged']),
  ];

  ProfileBloc() {
    fly = GetIt.instance<Fly<dynamic>>();
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

    Node billingInfoNode = Node(
      name: 'mySP',
      args: {},
      cols: [
        'billing_status',
        'street_name',
        'street_number',
        'phone',
        'postal_code',
        'city',
        'iban',
        'bic',
        'small_company',
        'tax_id'
      ],
    );

    Map mySP =
        await fly.query([billingInfoNode], parsers: {"mySP": SP.empty()});
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
      'tax_id':sp.taxId.isEmpty?null:sp.taxId
    };

    Node billingInfoNode = Node(
      name: 'updateSP',
      args: argMap,
      cols: [
        'billing_status',
        'info_status',
        'street_name',
        'street_number',
        'phone',
        'postal_code',
        'city',
        'iban',
        'bic',
      ],
    );

    Map mySP = await fly
        .mutation([billingInfoNode], parsers: {"updateSP": SP.empty()});
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
    Node updateSpMutation = Node(
        name: "updateSP",
        args: {
          "id": sp.id,
          "business_certificate": sp.business_certificate,
          "insurance": sp.insurance,
          "contract": sp.contract,
          "documents_status": true,
        },
        cols: this.spCols);

    Map updatedSP = await fly
        .mutation([updateSpMutation], parsers: {"updateSP": SP.empty()});
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
    if(!sp.small_company && (sp.taxId==null || sp.taxId.trim().isEmpty)){
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

    Node updateSpMutation =
        Node(name: "updateSP", args: args, cols: this.spCols);
    print(updateSpMutation.toString());
    Map updatedSP = await fly
        .mutation([updateSpMutation], parsers: {"updateSP": SP.empty()});
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
    List<Node> areasList = List();
    //TODO::THIS PART IS ALSO IN AREAS SCREEN => NEXTBUTTON AND SHOULD BE PUT IN ONE PLACE
    int areasSum = sp.areas == null ? 0 : sp.areas.length;
    int addedSum = sp.addedAreas == null ? 0 : sp.addedAreas.length;
    int deletedSum = sp.deletedAreas == null ? 0 : sp.deletedAreas.length;
    bool areasStatus = areasSum + addedSum - deletedSum != 0;

    areasList.add(Node(
        name: "updateSP",
        args: {
          "id": int.parse(sp.id),
          "areas_status": areasStatus,
          'input': {
            'areas': <String, dynamic>{
              'create': sp.addedAreas
                  .map((e) => {"from": e.from, "to": e.to})
                  .toList(),
              'delete': sp.deletedAreas.map((e) => e.id).toList()
            }
          },
        },
        cols: this.spCols));

    Map updatedSP =
        await fly.mutation(areasList, parsers: {"updateSP": SP.empty()});
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
    List<Node> servicesNodes = List();
    //TODO::THIS PART IS ALSO IN SERVICES SCREEN => NEXTBUTTON AND SHOULD BE PUT IN ONE PLACE
    int servicesSum = sp.services == null ? 0 : sp.services.length;
    int selectedSum =
        sp.selectedServices == null ? 0 : sp.selectedServices.length;
    int deSeletedSum =
        sp.deSelectedServices == null ? 0 : sp.deSelectedServices.length;
    bool servicesState = (servicesSum + selectedSum - deSeletedSum) > 0;
    Set<String> conCats = buildConCats();
    Set<String> disConCats = buildDisConCats();
    // update the SP state
    servicesNodes.add(Node(
        name: "updateSP",
        args: {
          "id": int.parse(sp.id),
          "services_status": servicesState,
          'input': {
            'services': <String, dynamic>{
              'connect': sp.selectedServices.map((e) => e.id).toList(),
              'disconnect':
                  sp.deSelectedServices.map((serv) => serv.id).toList()
            },
            'categories': <String, dynamic>{
              'connect': conCats.toList(),
              'disconnect': disConCats.toList()
            }
          },
        },
        cols: this.spCols));

    Map resluts =
        await fly.mutation(servicesNodes, parsers: {"updateSP": SP.empty()});
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
    Node updateSpMutation = Node(
      name: "updateSP",
      args: {
        "id": int.parse(this.sp.id),
        'ready_for_verify': true,
        // "input": {

        // },
      },
      cols: this.spCols,
    );

    dynamic updatedSP = await fly
        .mutation([updateSpMutation], parsers: {"updateSP": SP.empty()});
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

    Node node;
    Map<String, dynamic> parsers;

    if (provider.user.role == CodeStrings.sp) {
      node = Node(name: 'mySP', cols: spCols);
      parsers = {"mySP": SP.empty()};
    } else if (provider.user.role == CodeStrings.worker) {
      node = Node(name: 'myWorker', cols: workerCols);
      parsers = {"myWorker": Technician.empty()};
    } else {
      throw AppException(false,
          name: "UserRoleInvalid", beautifulMsg: AppStrings.noRole);
    }

    Map result = await fly.query([node], parsers: parsers);

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
    Node sps = Node(name: 'mySP', cols: spCols);
    Map<String, dynamic> parsers = {"mySP": SP.empty()};
    // check if we dont have a SP
    Map result = await fly.query([sps], parsers: parsers);
    this.sp = result['mySP'];
  }

  Future createSP() async {
    Node createSpMutation = Node(
        name: "createSP",
        args: {
          "auth_user_id": int.parse(provider.user.id),
        },
        cols: this.spCols);
    Map<String, Parser<dynamic>> parsers = {"createSP": SP.empty()};
    Map result = await fly.mutation([createSpMutation], parsers: parsers);
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
