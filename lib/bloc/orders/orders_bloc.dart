import 'package:get_it/get_it.dart';
import 'package:load/load.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sercl/PODO/Order.dart';
import 'package:sercl/PODO/Orders.dart';

import 'package:sercl/PODO/Invitation.dart';
import 'package:sercl/PODO/SP.dart';
import 'package:sercl/PODO/Service.dart';
import 'package:sercl/Utilities/FCMProvider.dart';
import 'package:sercl/bloc/bloc.dart';

import 'package:sercl/bloc/orders/bloc.dart';

import 'package:sercl/dialog_provider/dialog_models.dart';
import 'package:sercl/dialog_provider/dialog_service.dart';
import 'package:sercl/services/OrdersService.dart';
import 'package:sercl/support/Auth/AppException.dart';
import 'package:sercl/support/Auth/AuthProvider.dart';
import 'package:sercl/support/Chat/chat_provider.dart';
import 'package:sercl/support/Fly/fly.dart';
import 'package:sercl/support/GraphClient/GraphQLBuilder.dart';
import 'package:sercl/support/Util.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/support/router.gr.dart';

class OrdersBloc extends BLoC<OrdersEvent> {
  final ordersStateSubject = PublishSubject<OrdersState>();
  //final chatStateSubject = BehaviorSubject<ChatState>();
  final FCMProvider fcmProvider = GetIt.instance<FCMProvider>();
  Fly _fly;
  Node _ordersQuery;
  final AuthProvider authprovider = GetIt.instance.get();
  SP sp;
  String name = "";
  Invitation selectedInvitation;
  Order selectedOrder;
  List<Invitation> myInvs = [];
  DialogService _dialogService = GetIt.instance<DialogService>();
  ChatProvider _provider;
  OrdersService _ordersService = GetIt.instance<OrdersService>();

  /* Currently selected zip code from filter screen */
  List<String> zipCode = [];

  /* Currently selected services from filter screen */
  List<Service> services = [];

  /* Current selected status from filter screen */
  List<String> status = [];

  /* List of services that the current sp has chosen in his profile */
  List<Service> spServices = [];

  //Map filters = Map<String, dynamic>();
  List<Map> filters = [];

  Order order;

  static List<dynamic> invitationCols = [
    "id",
    "status",
    "price",
    "chat_room",
    Node(
      name: "request",
      cols: [
        "id",
        "description",
        "created_at",
        "date",
        "record",
        "status",
        "date",
        Node(name: "category", cols: [
          "id",
          "name",
          "icon",
          "color",
        ]),
        Node(name: "customer", cols: ["id", "name", "avg_rating"]),
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
    ),
    Node(
      name: "order",
      cols: [
        Node(
          name: "serviceProvider",
          cols: ['id'],
        )
      ],
    )
  ];

  OrdersBloc() {
    _fly = GetIt.instance<Fly<dynamic>>();
    _registerToNotificationActions();
  }

  static List _orderCols = [
    'id',
    Node(name: "serviceProvider", cols: [
      "id",
    ]),
    'status',
    'customer_name',
    'email',
    'street_no',
    'street_name',
    'phone',
    "receipt",
    'description',
    'postcode',
    'created_at',
    'date',
    'payment_method',
    Node(name: "invitation", cols: invitationsNode.cols),
    Node(name: "serviceProvider", cols: ["id", "name"]),
    Node(name: "customer", cols: ["id", "avg_rating", "name"]),
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
    Node(name: "visits", cols: [
      "id",
      "time",
      "status",
      "work_done",
      "navigation_id",
      "started",
      "finished",
      Node(name: "workers", cols: ["id", "name", "email"])
    ]),
    Node(name: "CustomerRating", cols: ["id", "rating", "comment"]),
    Node(name: "SPRating", cols: ["id", "rating", "price_rating", "comment"]),
  ];

  List<dynamic> spCols = [
    'id',
    Node(
        name: "orders",
        args: {
          "where": {"column": "_STATUS", "operator": "_NEQ", "value": "_CLOSED"}
        },
        cols: _orderCols),
    invitationsNode,
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

  static Node invitationsNode = Node(
    name: "invitations",
    args: {},
    cols: invitationCols,
  );

  static Node allInvitationsNode = Node(
    name: "invitations",
    args: {},
    cols: invitationCols,
  );

  @override
  void dispatch(OrdersEvent event) async {
    if (event is AvailableWorkersRequested) {
      _getAvailableWorkers(event).catchError((e) {
        hideLoadingDialog();
        if (e is AppException) {
          GetIt.instance<DialogService>()
              .showDialog(ErrorDialog(message: e.beautifulMsg));
        }
      });
    }

    if (event is RejectInvitationRequested) {
      rejectInvitation(event.invitationId, event.spID);
    }

    if (event is UploadReceiptRequested) {
      if (event.file == null) {
        uploadReceipt("", event.orderId);
      } else {
        Util.stringFromFile(event.file).then((stringFile) {
          uploadReceipt(stringFile, event.orderId);
        });
      }
    }

    if (event is UpdateInvitationRequested) {
      try {
        showLoadingDialog();
        if (event.invitation.status == "accepted" && event.accept) {
          ordersStateSubject.sink
              .add(UpdatedInvitationIs(event.invitation, true));
          return;
        }
        await _updateInvitation(event.spID, event.invitation, event.accept)
            .catchError((onError) => _showErrorDialog(onError, true));
      } finally {
        hideLoadingDialog();
      }
    }

    if (event is InvitationSelected) {
      setSelectedInvitation(event.invitation);
    }

    if (event is DetailsScreenLaunched) {
      if (event.isOrder) {
        ordersStateSubject.sink.add(SelectedOrderIs(this.selectedOrder));
      } else {
        ordersStateSubject.sink
            .add(SelectedInvitationIs(this.selectedInvitation));
      }
    }

    if (event is SetPaidRequested) {
      setAsPaid(event.orderId);
    }

    if (event is GetInvitation) {
      if (event.update) {
        await updateSPInvs();
      }
      ordersStateSubject.add(InvitationIs(this
          .sp
          .invitations
          .firstWhere((invitation) => invitation.id == event.id)));
    }

//    if (event is PriceAdded) {
//      try {
//        await _updatePrice(
//            id: event.spID,
//            price: event.price,
//            invitationId: event.invitationId);
//      } catch (e) {
//        chatStateSubject.add(RetractFailed());
//      }
//    }

    if (event is InvitationsTabClicked) {
      _getOrders(type: AppStrings.invitations);
    }

    if (event is AssignmentsTabClicked) {
      _getOrders(type: AppStrings.assignments);
    }

    if (event is FiltersScreenLaunched) {
      if (spServices != null && spServices.isNotEmpty) {
        ordersStateSubject.sink
            .add(FilterDataIs(services, status, spServices, zipCode));
        return;
      }
      _getServices();
    }

    if (event is ClearFiltersRequested) {
      services = [];
      status = [];
      filters = [];
      zipCode = [];
      _getOrders();
    }
    if (event is OrderRequestedById) {
      orderRequestedById(event.id);
    }

    if (event is ComplainScreenLaunched) {
      ordersStateSubject.sink.add(OrderIs(this.order));
    }

    if (event is ComplainAdded) {
      await addComplain(event);
    }
    if (event is OrderSelected) {
      this.selectedOrder = event.order;
    }
    if (event is ArchiveSelected) {
      try {
        showLoadingDialog();
        await getArchive();
      } finally {
        hideLoadingDialog();
      }
    }
  }

  void _registerToNotificationActions() {
    fcmProvider.notificationSubject.listen((payload) async {
      if (payload['tag'] == 'request') {
        await _getInvitationByRequestId(payload['id']);
        MainRouter.navigator.pushNamed(MainRouter.invitationOrderDetails,
            arguments: CodeStrings.AS_INV);
      }
    });
  }

  Future<void> rejectInvitation(String invitationId, String spId) async {
    showLoadingDialog();
    Map updateMap = {
      "id": invitationId,
    };

    updateMap["status"] = CodeStrings.r_rejected;

    sp = await _ordersService.rejectInv(spId, updateMap);
    sp.invitations = removeAssignments(sp.invitations);
    ordersStateSubject.add(InvitationsAreAfterRejection(sp.invitations));
    hideLoadingDialog();
    //linkRoomInvReq();
  }

  void _getOrderById(String id) {
    selectedOrder = sp.orders.firstWhere((Order order) => order.id == id);
  }

  void _getInvitationByRequestId(String id) async {
    await _getOrders();
    selectedInvitation =
        sp.invitations.firstWhere((invitation) => invitation.request.id == id);
  }

  Future<void> getArchive() async {
    SP tempSp = await _ordersService.getArchives();
    ordersStateSubject.sink.add(OrdersAreFetched(tempSp.orders));
  }

  Future<void> orderRequestedById(String id) async {
    SP tempSp = await _ordersService.getOrderById(id);
    ordersStateSubject.sink.add(OrderIs(tempSp.orders[0]));
    this.order = tempSp.orders[0];
  }

  Future<void> addComplain(event) async {
    String desc = event.description;
    desc = desc.replaceAll("\n", " ");

    showLoadingDialog();
    Map result = await _ordersService.addComplain(
        event.spID, event.spEmail, desc, order);
    if (result['updateSP'] != null) {
      this.sp = result['updateSP'];
      hideLoadingDialog();
      ordersStateSubject.sink.add(ComplainIS());
    }
  }

  void setSelectedInvitation(Invitation inv) {
    this.selectedInvitation = inv;
  }

  void _showErrorDialog(dynamic onError, bool hideDialog) {
    //if (hideDialog) hideLoadingDialog();
    if (onError is AppException) {
      _dialogService.showDialog(ErrorDialog(message: onError.beautifulMsg));
      if (onError.beautifulMsg == "Cannot Change Invitation Status") {
        _getOrders(type: AppStrings.invitations);
      }
    } else {
      _dialogService.showDialog(ErrorDialog(message: AppStrings.errorOccured));
    }
  }

  Future _updatePrice({String id, String price, String invitationId}) async {
    //showLoadingDialog(tapDismiss: false);

    Map result = await _ordersService.updatePrice(id, price, invitationId);
    print(result);
    if (result['updateSP'] == null) {
      print("Couldn't retract price");
    }

    /*
    if (result['updateSP'] != null) {
      this.sp = result['updateSP'];
      hideLoadingDialog();
    }
    ordersStateSubject.sink.add(PriceUpdated( this.sp.invitations.firstWhere((invitation) => invitation.id == invitationId)));
    */
  }

  Future _updateInvitation(String spID, Invitation invitation, accept) async {
    print("ID Is ${invitation.id}");
    String state = accept ? CodeStrings.r_accepted : CodeStrings.r_rejected;

    //showLoadingDialog();

    dynamic result = await _ordersService.updateInv(spID, invitation, state);
    if (result['updateSP'] != null) {
      this.sp = result['updateSP'];
      // Iterable<Invitation> one =
      //     this.sp.invitations.where((inv) => inv.id == invitation.id);
      // ordersStateSubject.sink.add(UpdatedInvitationIs(one.toList()[0], accept));
      hideLoadingDialog();
    }
    sp.invitations = removeAssignments(sp.invitations);
    ordersStateSubject.sink.add(InvitationsAre(this.sp.invitations));
    if (accept) {
      Invitation updatedInv = this
          .sp
          .invitations
          .firstWhere((Invitation inv) => inv.id == invitation.id);
      ordersStateSubject.sink.add(UpdatedInvitationIs(updatedInv, true));
    }
  }

//need some work , not ready
  Future _getAvailableWorkers(AvailableWorkersRequested event) async {
    dynamic result = await _ordersService.getAvailableWorkers();
    if (result['workers'] == null) {
      throw AppException(true, beautifulMsg: AppStrings.cantGetWorkers);
    } else
      hideLoadingDialog();
  }

  Future<void> uploadReceipt(String receipt, String orderId) async {
    showLoadingDialog(tapDismiss: false);
    dynamic result =
        await _ordersService.uploadReceipt(receipt, orderId, this.sp.id);
    if (result['updateSP'] != null) {
      this.sp = result['updateSP'];
      hideLoadingDialog();
      ordersStateSubject.sink.add(ReceiptUploaded(
          this.sp.orders.firstWhere((order) => order.id == orderId)));
      hideLoadingDialog();
    }
  }

  Future<void> setAsPaid(String orderId) async {
    showLoadingDialog(tapDismiss: false);
    dynamic result = await _ordersService.setAsPaid(orderId, this.sp.id);
    if (result['updateSP'] != null) {
      this.sp = result['updateSP'];
      hideLoadingDialog();
      ordersStateSubject.sink.add(OrdersAreFetched(this.sp.orders));
      hideLoadingDialog();
    }
  }

  Future<void> _getOrders({String type}) async {
    showLoadingDialog();
    dynamic results = await _ordersService.getOrders();
    hideLoadingDialog();

    this.sp = results['mySP'];
    if (type == null || type == AppStrings.invitations) {
      sp.invitations = removeAssignments(sp.invitations);

      ///TODO: Notify screens for the invitations list
    }
  }

  List<Invitation> removeAssignments(List invs) {
    myInvs = [];
    for (Invitation inv in invs) {
      if (inv.status == CodeStrings.inv_accepted ||
          inv.status == CodeStrings.inv_pending ||
          inv.status == CodeStrings.inv_in_progress) {
        myInvs.add(inv);
      }
    }
    return myInvs;
  }

  Future<void> _getServices() async {
    showLoadingDialog();
    dynamic results = await _ordersService.getServices();
    hideLoadingDialog();

    SP tempSp = results['mySP'];
    spServices = tempSp.services;

    ordersStateSubject.sink
        .add(FilterDataIs(services, status, spServices, zipCode));
  }

  Future<void> updateSPInvs() async {
    dynamic results = await _ordersService.updateSPInvs();
    hideLoadingDialog();

    SP tempSp = results['mySP'];
    this.sp.invitations = tempSp.invitations;
  }

  Future<void> searchForOrders(event) async {
    print(event.orders.length);
  }

  void dispose() {
    ordersStateSubject.close();
  }
}

enum Filters { CATEGORY_ID, EQ, LIKE }
