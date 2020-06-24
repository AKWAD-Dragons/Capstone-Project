import 'package:flutter/material.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/support/router.gr.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;
  final Color bodyColor;
  //custom app bar , if not found , the default app bar for the theme is created
  final AppBar appBar;
  final Text title;
  final bool canPopUp;
  final Widget bottom;
  final Function(BuildContext context) builder;
  MainScaffold(
      {Key key,
      this.child,
      this.bodyColor,
      this.appBar,
      this.title,
      this.builder,
      this.canPopUp = false,
      this.bottom})
      //one of builder and child must be null
      : assert((builder == null && child != null) ||
            (builder != null && child == null)),
        super(key: key);
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //this is because when the bg color for the scaffold = the color of the tabbar indicator
        //the tab tab doesnt show the color of the indicator
        color: AppColors.accentColor,
        child: Scaffold(
            bottomNavigationBar: widget.bottom ?? null,
            backgroundColor: Colors.transparent,
            appBar: widget.appBar ??
                AppBar(
                  leading: widget.canPopUp
                      ? IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            MainRouter.navigator.pop(context);
                          },
                        )
                      : null,
                  centerTitle: true,
                  elevation: 0.0,
                  backgroundColor: AppColors.accentColor,
                  title: widget.title ?? Container(),
                ),
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: widget.bodyColor ?? AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimens.parentContainerRadius),
                  topRight: Radius.circular(AppDimens.parentContainerRadius),
                ),
              ),
              child: widget.child ?? widget.builder,
            )));
  }
}
