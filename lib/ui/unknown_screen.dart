import 'package:flutter/material.dart';

class UnknownScreen extends StatefulWidget {
  @override
  _UnknownScreenState createState() => _UnknownScreenState();
}

class _UnknownScreenState extends State<UnknownScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Screen in progress'),
      ),
    );
  }
}
