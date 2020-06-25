import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sercl/PODO/LocalError.dart';
import 'package:sercl/bloc/ErrorBloc.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/support/router.gr.dart';

class ErrorSnackWidget extends StatefulWidget {
  final String route;
  Map<int, Function> actionMap;

  ErrorSnackWidget(this.route, {this.actionMap});

  @override
  ErrorSnackWidgetState createState() => ErrorSnackWidgetState();
}

class ErrorSnackWidgetState extends State<ErrorSnackWidget> {
  Stream<LocalError> _stream;
  StreamSubscription s;

  @override
  void initState() {
    //_stream = ErrorBloc.makeStream(widget.route);
    s = _stream.listen((LocalError error) {
      //if the widget is not on screen don't show the error
      if (!ModalRoute
          .of(context)
          .isCurrent) return;

      if (error != null) {
        setState(() {
          WidgetsBinding.instance.addPostFrameCallback((_) async{
            await showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(fontFamily: 'Din'),
                  home: Scaffold(
                    backgroundColor: Color(0x00000000),
                    body: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Color(0x00000000),
                      ),
                      child: InkWell(
                          enableFeedback: false,
                          onLongPress: () {},
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          onTap: () => MainRouter.navigator.pop(context),
                          child: Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 20,),
                                  Center(
                                      child: Text(
                                        "حدث خطأ",
                                        style: TextStyle(
                                            color: AppColors.errorColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 30),
                                    child: Text(
                                      error.msg,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.primaryColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                );
              },
            );
            if(widget.actionMap==null || widget.actionMap[error.code]==null) return;
            widget.actionMap[error.code]();
          });
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    s.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
