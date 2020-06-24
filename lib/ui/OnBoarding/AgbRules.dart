import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sercl/resources/AGBSTRING.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/support/router.gr.dart';

class AgbRules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            screenHeader(context),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.all(16
              ),
              child: Html(
                data: AGBString().html,

              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget screenHeader(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 230,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/banner1.png"),
                  fit: BoxFit.cover)),
        ),
        Container(
          margin: EdgeInsets.only(
              left: AppDimens.screenPadding, right: AppDimens.screenPadding),
          height: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: InkWell(
                  child: Image.asset(
                    "assets/images/back.png",
                    width: 25,
                    height: 25,
                  ),
                  onTap: () => MainRouter.navigator.pop(context),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  AppStrings.agbRules,
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                AppStrings.termsAndConditions,
                style: TextStyle(color: AppColors.white, fontSize: 16),
              )
            ],
          ),
        )
      ],
    );
  }
}
