import 'package:get_it/get_it.dart';
import 'package:load/load.dart';

import '../PODO/Invitation.dart';
import '../PODO/Order.dart';
import '../PODO/Orders.dart';
import '../PODO/SP.dart';
import '../resources/res.dart';
import '../support/Fly/fly.dart';
import '../support/GraphClient/GraphQLBuilder.dart';

class OrdersService {
  Fly _fly;
  Node _ordersQuery;
  OrdersService() {
    _fly = GetIt.instance<Fly<dynamic>>();
  }
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

  Future<dynamic> getAvailableWorkers() async {
    Node query = Node(
        name: 'availableWorkers',
        args: {'date_time': 'date_time'},
        cols: ['workers']);
    showLoadingDialog(tapDismiss: false);
    dynamic result =
        await _fly.mutation([query], parsers: {'workers': Orders.empty()});
    return result;
  }

  Future<SP> rejectInv(String spId, Map<dynamic, dynamic> updateMap) async {
    Node node = Node(
      name: CodeStrings.updateSPNodeName,
      args: {
        "id": spId,
        "input": {
          "invitations": {
            "update": updateMap,
          }
        }
      },
      cols: spCols,
    );
    Map result = await _fly
        .mutation([node], parsers: {CodeStrings.updateSPNodeName: SP.empty()});
    SP sp = result[CodeStrings.updateSPNodeName];
    return sp;
  }

  Future<SP> getArchives() async {
    Node node = Node(
      name: "mySP",
      cols: [
        Node(
          name: "orders",
          cols: _orderCols,
          args: {
            "where": {
              "column": "_STATUS",
              "value": "_CLOSED",
            },
          },
        ),
      ],
    );
    Map result = await _fly.query([node], parsers: {'mySP': SP.empty()});
    SP tempSp = result["mySP"];
    return tempSp;
  }

  Future<SP> getOrderById(String id) async {
    Node node = Node(
      name: "mySP",
      cols: [
        Node(
          name: "orders",
          cols: _orderCols,
          args: {
            "where": {
              "column": "_ID",
              "value": id,
            },
          },
        ),
      ],
    );
    Map result = await _fly.query([node], parsers: {'mySP': SP.empty()});
    SP tempSp = result["mySP"];
    return tempSp;
  }

  Future<dynamic> addComplain(
      String spID, String spEmail, String desc, Order order) async {
    Node node = Node(
        name: 'updateSP',
        args: {
          'id': int.parse(spID),
          'input': {
            'complains': {
              'create': {
                "phone": " ",
                "email": spEmail,
                "description": desc,
                "complainer": "_SERVICE_PROVIDER",
                "order": {'connect': order.id}
              }
            },
          },
        },
        cols: spCols);
    Map result = await _fly.mutation([node], parsers: {'updateSP': SP.empty()});
    return result;
  }

  Future<dynamic> updatePrice(
      String id, String price, String invitationId) async {
    Node query = Node(
        name: 'updateSP',
        args: {
          'id': int.parse(id),
          'input': {
            'invitations': {
              'update': {'id': invitationId, 'price': price}
            },
          },
        },
        cols: spCols);
    //showLoadingDialog(tapDismiss: false);

    Map result =
        await _fly.mutation([query], parsers: {'updateSP': SP.empty()});
    return result;
  }

  Future<dynamic> updateInv(
      String spID, Invitation invitation, String state) async {
    Node query = Node(name: 'updateSP', args: {
      'id': int.parse(spID),
      'input': {
        'invitations': {
          'update': {'id': int.parse(invitation.id), 'status': state}
        },
      },
    }, cols: [
      allInvitationsNode
    ]);
    dynamic result =
        await _fly.mutation([query], parsers: {'updateSP': SP.empty()});
    return result;
  }

  Future<dynamic> uploadReceipt(
      String receipt, String orderId, String spID) async {
    Node query = Node(
        name: 'updateSP',
        args: {
          'id': int.parse(spID),
          'input': {
            'orders': {
              'update': {
                'id': orderId,
                'receipt': receipt == "" ? null : receipt
              }
            },
          },
        },
        cols: spCols);
    dynamic result =
        await _fly.mutation([query], parsers: {'updateSP': SP.empty()});
    return result;
  }

  Future<dynamic> setAsPaid(String orderId, String spID) async {
    Node query = Node(
        name: 'updateSP',
        args: {
          'id': int.parse(spID),
          'input': {
            'orders': {
              'update': {'id': orderId, 'status': "_PAID"}
            },
          },
        },
        cols: spCols);
    dynamic result =
        await _fly.mutation([query], parsers: {'updateSP': SP.empty()});
    return result;
  }

  Future<dynamic> getOrders() async {
    _ordersQuery = Node(name: "mySP", args: {}, cols: spCols);
    dynamic results =
        await _fly.query([_ordersQuery], parsers: {'mySP': SP.empty()});
    return results;
  }

  Future<dynamic> getServices() async {
    _ordersQuery = Node(name: "mySP", args: {}, cols: [
      Node(name: "services", args: {}, cols: [
        'id',
        'name',
      ]),
    ]);
    dynamic results =
        await _fly.query([_ordersQuery], parsers: {'mySP': SP.empty()});
    return results;
  }

  Future<dynamic> updateSPInvs() async {
    Node node = Node(name: "mySP", args: {}, cols: [invitationsNode]);
    dynamic results = await _fly.query([node], parsers: {'mySP': SP.empty()});
    return results;
  }
}
