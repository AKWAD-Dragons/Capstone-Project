import 'package:flutter/material.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/support/router.gr.dart';

class OnBoardingBackButton extends StatefulWidget {
  @override
  _BackButtonState createState() => _BackButtonState();
}

class _BackButtonState extends State<OnBoardingBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MainRouter.navigator.pop(context);
      },
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  topRight: Radius.circular(50))),
          height: 60,
          margin: EdgeInsets.only(bottom: 20),
          child: Container(
              padding: EdgeInsets.only(
                  left: 25, right: 25),
              child:  Image.asset(
                "assets/images/back.png",
              )
          )),
    );
  }
}
