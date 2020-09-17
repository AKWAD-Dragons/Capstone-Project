import 'package:get_it/get_it.dart';

import '../PODO/SP.dart';
import '../PODO/Technician.dart';
import '../resources/res.dart';
import '../support/Auth/AppException.dart';
import '../support/Fly/fly.dart';
import '../support/GraphClient/GraphQLBuilder.dart';

class ProfileService {
  Fly fly;
  ProfileService() {
    fly = GetIt.instance<Fly<dynamic>>();
  }

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

  Future<Map<dynamic, dynamic>> getSPBillingInfo() async {
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
    return mySP;
  }

  Future<Map<dynamic, dynamic>> saveBillingInfo(
      Map<String, dynamic> argMap) async {
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
    return mySP;
  }

  Future<Map<dynamic, dynamic>> saveCompanyFiles(SP sp) async {
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
    return updatedSP;
  }

  Future<Map<dynamic, dynamic>> saveCompanyInfo(
      Map<String, dynamic> args) async {
    Node updateSpMutation =
        Node(name: "updateSP", args: args, cols: this.spCols);
    print(updateSpMutation.toString());
    Map updatedSP = await fly
        .mutation([updateSpMutation], parsers: {"updateSP": SP.empty()});
    return updatedSP;
  }

  Future<Map<dynamic, dynamic>> saveCompanyAreas(
      SP sp, bool areasStatus) async {
    Node areasList = Node(
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
        cols: this.spCols);

    Map updatedSP =
        await fly.mutation([areasList], parsers: {"updateSP": SP.empty()});
    return updatedSP;
  }

  Future<Map<dynamic, dynamic>> saveCompanyServices(Set<String> conCats,
      Set<String> disConCats, SP sp, bool servicesState) async {
    Node servicesNodes = Node(
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
        cols: this.spCols);

    Map resluts =
        await fly.mutation([servicesNodes], parsers: {"updateSP": SP.empty()});
    return resluts;
  }

  Future<dynamic> submitCompanyForReview(SP sp) async {
    Node updateSpMutation = Node(
      name: "updateSP",
      args: {
        "id": int.parse(sp.id),
        'ready_for_verify': true,
        // "input": {

        // },
      },
      cols: this.spCols,
    );

    dynamic updatedSP = await fly
        .mutation([updateSpMutation], parsers: {"updateSP": SP.empty()});
    return updatedSP;
  }

  Future<Map<dynamic, dynamic>> updateSP() async {
    Node sps = Node(name: 'mySP', cols: spCols);
    Map<String, dynamic> parsers = {"mySP": SP.empty()};
    // check if we dont have a SP
    Map result = await fly.query([sps], parsers: parsers);
    return result;
  }

  Future<Map<dynamic, dynamic>> createSP(String id) async {
    Node createSpMutation = Node(
        name: "createSP",
        args: {
          "auth_user_id": int.parse(id),
        },
        cols: this.spCols);
    Map<String, Parser<dynamic>> parsers = {"createSP": SP.empty()};
    Map result = await fly.mutation([createSpMutation], parsers: parsers);
    return result;
  }

  Future<Map<dynamic, dynamic>> homePageLaunched(String role) async{
    Node node;
    Map<String, dynamic> parsers;

    if (role == CodeStrings.sp) {
      node = Node(name: 'mySP', cols: spCols);
      parsers = {"mySP": SP.empty()};
    } else if (role == CodeStrings.worker) {
      node = Node(name: 'myWorker', cols: workerCols);
      parsers = {"myWorker": Technician.empty()};
    } else {
      throw AppException(false,
          name: "UserRoleInvalid", beautifulMsg: AppStrings.noRole);
    }

    Map result = await fly.query([node], parsers: parsers);
    return result;
  }
}
