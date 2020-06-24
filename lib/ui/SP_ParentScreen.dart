import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sercl/Widgets/BottomNavigationBar.dart';
import 'package:sercl/ui/Orders/Orders.dart';
import 'package:sercl/ui/unknown_screen.dart';
import 'package:sercl/resources/res.dart';

class SP_ParentScreen extends StatefulWidget {
  @override
  _SP_ParentScreenState createState() => _SP_ParentScreenState();
}

class _SP_ParentScreenState extends State<SP_ParentScreen> {
  int _current = 0;
  Widget _body;

  @override
  void initState() {
    _body = screenMap[0];
    super.initState();
  }

  Map<int, Widget> screenMap = {
    0: OrdersPage("NOMODE"),
    1: UnknownScreen(),
    2: UnknownScreen(),
    3: UnknownScreen()
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: _body,
    );
  }

  _setScreen(int i){
    setState(() {
      _current = i;
      _body = screenMap[i];
    });
  }

}
