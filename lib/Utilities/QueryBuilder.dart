import 'dart:convert';
import 'package:flutter/foundation.dart';
final String TYPE_NOT_SUPPORTED = "Parameter No Supported";

class QueryBuilder {
  Map<String, dynamic> _data = Map();
  List<String> _selectList = List();
  List<Map<String, dynamic>> _insert = List();
  List<String> _withList = List();
  List<String> _runnableList = List();
  _Where _where;
  int _limit;
  List<String> _orderBy = List(2);

  QueryBuilder select(dynamic selects) {
    if (selects is String) {
      _selectList.add(selects);
      return this;
    }
    if (selects is List<String>) {
      _selectList.addAll(selects);
      return this;
    }
    throw Exception(
        TYPE_NOT_SUPPORTED + ": Select only accepts Strings or List<String>" + selects + "Passed");
  }

  QueryBuilder insert(Map<String,dynamic>map) {
    _insert.add(map);
    return this;
  }

  QueryBuilder where(String col, String op, dynamic val) {
    return _simpleWhere(_Where("and", [col,op,val]));
  }

  QueryBuilder orWhere(String col, String op, dynamic val) {
    return _simpleWhere(_Where("or", [col,op,val]));
  }

  QueryBuilder innerWhere(QueryBuilder builder(QueryBuilder qb)){
    QueryBuilder qb = QueryBuilder();
    return _simpleWhere(_Where("and", [builder(qb).getWhere()]));
  }

  QueryBuilder orInnerWhere(QueryBuilder builder(QueryBuilder qb)){
    QueryBuilder qb = QueryBuilder();
    return _simpleWhere(_Where("or", [builder(qb).getWhere()]));
  }

  QueryBuilder _simpleWhere(_Where where) {
    if(_where == null){
      _where = _Where(where.type, List());
    }
    if(where.type !=null && where.type!=_where.type) {
      throw("Same Level Where must be same type as the first type");
    }
    where.type = null;
    if(where.value.first is String)
      _where.value.add(where);
    else{
      _where.value.add(where.value.first);
    }
    return this;
  }

  QueryBuilder limit(int limit) {
    _limit = limit;
    return this;
  }

  QueryBuilder withs(dynamic value) {
    if (value is String) {
      _withList.add(value);
      return this;
    }
    if (value is List<String>) {
      _withList.addAll(value);
      return this;
    }
    throw Exception(
        TYPE_NOT_SUPPORTED + ": withs only accepts Strings or List<String>");
  }

  QueryBuilder runnables(dynamic value) {
    if (value is String) {
      _runnableList.add(value);
      return this;
    }
    if (value is List<String>) {
      _runnableList.addAll(value);
      return this;
    }
    throw Exception(
        TYPE_NOT_SUPPORTED + ": runnables only accepts Strings or List<String>");
  }

  QueryBuilder orderBy(String orderBy, {bool ASC = true}) {
    _orderBy[0] = (orderBy);
    _orderBy[1] = (ASC ? 'ASC' : 'DESC');
    return this;
  }

  Map<String, dynamic> commit() {
    Map<String, dynamic> query = Map();
    if (_selectList.isNotEmpty && _insert.isNotEmpty) {
      throw ("you can't select and insert in the same query");
    }
    if (_selectList.isNotEmpty) {
      _data["select"] = _selectList;
    }
    if (_insert.isNotEmpty) {
      _data["insert"] = _insert;
    }
    if (_orderBy != null && _orderBy[0] != null) {
      query["orderBy"] = _orderBy;
    }
    if (_limit != null) {
      query["limit"] = _limit;
    }
    if (_where != null) {
      query["where"] = _where;
    }

    if (_withList.length > 0) {
      query["with"] = _withList;
    }

    if (_runnableList.length > 0) {
      _data["runnables"] = _runnableList;
    }


    _data["query"] = query;

    return _data;
  }

  _Where getWhere() {
    return _where;
  }
}

class _Where{
  String type;
  List<dynamic> value;

  _Where(this.type,this.value);

  Map<String, dynamic> toJson() {
    if(type==null)
      return {
        'value': value,
      };
    return {
      'type': type,
      'value': value,
    };
  }
}