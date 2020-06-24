import 'package:flutter/material.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/support/router.gr.dart';

class ScreenHeader extends StatefulWidget {
  @override
  ScreenHeader(this.title);

  final String title;
  @override
  _ScreenHeaderState createState() => _ScreenHeaderState();
}

class _ScreenHeaderState extends State<ScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            height: 80,
            color: AppColors.primaryColor,
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset("assets/images/banner1.png"),
            )),
        Container(
          margin: EdgeInsets.only(left: AppDimens.screenPadding),
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      MainRouter.navigator.pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: AppDimens.screenPadding),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
