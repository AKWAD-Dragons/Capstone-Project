import 'dart:convert';

import 'package:sercl/Utilities/QueryBuilder.dart';
import 'package:sercl/provider/shared_prefrence_provider.dart';
import 'package:sercl/resources/links.dart';
import 'package:sercl/support/Auth/AuthMethod.dart';
import 'package:sercl/support/Auth/User.dart';
import 'package:sercl/support/Fly/fly.dart';
import 'package:sercl/support/GraphClient/GraphQLBuilder.dart';

class EmailLoginMethod implements AuthMethod {
  @override
  String serviceName = 'email';
  String _email;
  String _password;

  Node signupMutation;

  String signupLink = AppLinks.protocol +
      AppLinks.subDomain +
      "." +
      AppLinks.apiBaseLink +
      "/graphql";
  Fly fly;

  EmailLoginMethod(this._email, this._password) {
    // create the query
    fly = Fly(this.signupLink);
    signupMutation = Node(name: "mutation", cols: [
      Node(name: 'auth_user', args: {
        "type": "email",
        "credentials": {"email": this._email, "password": this._password},
      }, cols: [
        'jwtToken',
        'expire',
        'id',
        'role'
      ])
    ]);
  }
  Future<void> saveUser(savedUser) async {
    final SharedPreferencesProvider sharedPrefs =
        SharedPreferencesProvider.instance();
    sharedPrefs.setUser(savedUser);
  }

  @override
  Future<AuthUser> auth() async {
    Map queryMap = {
      "operationName": null,
      "variables": {},
      "query": GraphQB(this.signupMutation).getQueryFor()
    };

     AuthUser user = await fly.request(query: queryMap, parser: AuthUser());
     saveUser(user);
     return user;
  }
}
