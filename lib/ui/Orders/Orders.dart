import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sercl/PODO/Order.dart';
import 'package:sercl/resources/res.dart';
import 'InvitationsList.dart';
import 'OrdersList.dart';

class OrdersPage extends StatefulWidget {
  String mode;

  OrdersPage(this.mode);

  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  static int invitationsTab = 1, assignmentsTab = 2;
  int currentTab = invitationsTab;
  Map statusMap = {
    CodeStrings.c_pending: AppStrings.s_pending,
    CodeStrings.r_in_progress: AppStrings.s_inProgress,
    CodeStrings.r_complete: AppStrings.s_complete,
    CodeStrings.c_paid: AppStrings.s_paid,
  };

  @override
  void initState() {
    currentTab = widget.mode == CodeStrings.mode_archive
        ? assignmentsTab
        : invitationsTab;
    super.initState();
  }

  updateStatusMap() {
    Map statusMap = {
      CodeStrings.c_pending: AppStrings.s_pending,
      CodeStrings.r_in_progress: AppStrings.s_inProgress,
      CodeStrings.r_complete: AppStrings.s_complete,
      CodeStrings.c_paid: AppStrings.s_paid,
    };
  }

  @override
  Widget build(BuildContext context) {
    updateStatusMap();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.accentColor,
        title: Text(AppStrings.assignments),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimens.screenContainerRadius),
            topRight: Radius.circular(AppDimens.screenContainerRadius),
          ),
        ),
        padding:
            EdgeInsets.only(left: 10, right: 10, top: AppDimens.screenPadding),
        child: Column(
          children: <Widget>[
            widget.mode != CodeStrings.mode_archive ? filterRow() : Container(),
            SizedBox(
              height: 16,
            ),
            Visibility(
              visible: currentTab == invitationsTab,
              child: InvitationsList(),
            ),
            Visibility(
              visible: currentTab == assignmentsTab,
              child: OrderList(widget.mode),
            )
          ],
        ),
      ),
    );
  }

  Widget paidButton(Order order) {
    return InkWell(
      onTap: () {},
      child: Container(
        color: AppColors.accentColor.withOpacity(0.2),
        padding: EdgeInsets.only(
            right: AppDimens.cardPadding,
            left: AppDimens.cardPadding,
            top: 10,
            bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                AppStrings.receivedPayment,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Text(
                AppStrings.setPaid,
                style: TextStyle(fontSize: 12, color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Widget filterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              currentTab = invitationsTab;
            });
          },
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
            decoration: BoxDecoration(
                color: currentTab == invitationsTab
                    ? AppColors.accentColor
                    : AppColors.lightFilter,
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              AppStrings.invitations,
              style: TextStyle(
                  color: currentTab == invitationsTab
                      ? AppColors.white
                      : AppColors.primaryColor),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            setState(() {
              currentTab = assignmentsTab;
            });
          },
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
            decoration: BoxDecoration(
                color: currentTab == assignmentsTab
                    ? AppColors.accentColor
                    : AppColors.lightFilter,
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              AppStrings.openAssignments,
              style: TextStyle(
                  color: currentTab == assignmentsTab
                      ? AppColors.white
                      : AppColors.primaryColor),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
