import 'package:sercl/resources/links.dart';
import 'package:sercl/support/Auth/User.dart';
import 'package:sercl/support/Fly/fly.dart';
import 'package:sercl/support/GraphClient/GraphQLBuilder.dart';

import 'callType.dart';

class GraphCall implements CallType {
  String signupLink = AppLinks.protocol +
      AppLinks.subDomain +
      AppLinks.apiBaseLink +
      "/graphql";
  Fly fly;

  GraphQB _authGraph = GraphQB(Node(name: "mutation", cols: [
    Node(name: "create_auth_user", args: {
      "type": "##type##",
      "credentials": {
        'token': "##token##",
      },
    }, cols: [
      'jwtToken',
      'expire'
    ])
  ]));

  GraphCall() {
    this.fly = Fly<AuthUser>(
        'https://${AppLinks.subDomain}.${AppLinks.apiBaseLink}/graphql');
  }

  @override
  Future<AuthUser> call(AuthUser authuser) async {
    String query = _authGraph.getQueryFor(args: {
      "##type##": "${authuser.credintials}",
      "##token##": "${authuser.token}"
    });

    Map<String, dynamic> newQuery = {
      "operationName": null,
      "variables": {},
      "query": "$query"
    };
    // print(newQuery.toString());
    // final AuthUser user =
    return await fly.request(query: newQuery, parser: AuthUser());

    //  print("TOKEN -----${user.token}");
  }
}
