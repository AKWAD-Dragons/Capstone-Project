import 'package:flutter/material.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/support/router.gr.dart';

class Toolbar extends StatefulWidget {
  @override
  const Toolbar({this.title, this.showSettings, this.showBack});

  final String title;
  final bool showSettings;
  final bool showBack;
  @override
  _ToolbarState createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: new BorderRadius.only(
            bottomRight: const Radius.circular(50.0),
            bottomLeft: const Radius.circular(50.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              2.0, // horizontal, move right 10
              2.0, // vertical, move down 10
            ),
          )
        ],
      ),
      child: Container(
          height: 130,
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 40, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Visibility(
                      visible: widget.showBack,
                      child: Container(
                          margin: EdgeInsets.only(top: 7, left: 20),
                          child:  InkWell(
                              onTap: () => MainRouter.navigator.pop(context),
                              child: Image.asset(
                                "assets/images/back.png",
                                width: 25,
                                height: 25,
                              ),
                          )
                      )
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Visibility(
                      visible: widget.showSettings,
                      child: InkWell(
                        onTap: () {
                          MainRouter.navigator.pushNamed("/Profile");
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Image.asset(
                            "assets/images/settings.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
