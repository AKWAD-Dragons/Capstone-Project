import 'package:get_it/get_it.dart';

import '../PODO/Categories.dart';
import '../support/Fly/fly.dart';
import '../support/GraphClient/GraphQLBuilder.dart';

class ServicesService {
  Fly fly;
  ServicesService() {
    fly = GetIt.instance<Fly<dynamic>>();
  }

  Future<dynamic> getServices() async {
    Node catQuery = Node(name: "Categories", cols: [
      'name',
      'icon',
      'color',
      Node(name: 'services', cols: [
        'id',
        'name',
        Node(name: "category", cols: [
          "id",
        ]),
      ])
    ]);

    dynamic results = await fly
        .query([catQuery], parsers: {'Categories': Categories.empty()});
    return results;
  }
}
