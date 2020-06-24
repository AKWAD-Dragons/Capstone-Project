import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:sercl/resources/res.dart';
import 'dart:async';
import 'package:sercl/support/router.gr.dart';
import 'package:sercl/bloc/orders/bloc.dart';
import 'package:sercl/PODO/Order.dart';
import 'package:get_it/get_it.dart';

class OrderList extends StatefulWidget {
  String mode;

  OrderList(this.mode);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  StreamSubscription<OrdersState> sub;
  List<Order> orders;
  final OrdersBloc _ordersBloc = GetIt.instance<OrdersBloc>();

  /* Hide assignments list */
  bool showEmptyView = true;

  Widget emptyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          "assets/images/no_work.png",
          width: 80,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          AppStrings.noWork,
          style: TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(
              left: AppDimens.screenPadding, right: AppDimens.screenPadding),
          child: Text(
            AppStrings.noWorkMsg,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.grayText),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimens.screenContainerRadius),
            topRight: Radius.circular(AppDimens.screenContainerRadius),
          ),
        ),
        child: showEmptyView
            ? emptyView()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: orders == null ? 0 : orders.length,
                itemBuilder: (BuildContext context, int index) =>
                    orderItem(context, index),
              ),
      ),
    );
  }

  Widget orderItem(BuildContext context, int position) {
    return InkWell(
      onTap: () {
        _ordersBloc.dispatch(OrderSelected(orders[position]));
        MainRouter.navigator.pushNamed(MainRouter.invitationOrderDetails,
            arguments: CodeStrings.AS_ORDER);
        print('ORDER ====> ${orders[position].id}');
      },
      child: Card(
        elevation: AppDimens.cardElevation,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.cardRadius)),
        child: Container(
          margin: EdgeInsets.only(top: 16, right: 0, left: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: AppDimens.cardPadding, bottom: 5),
                child: Text(
                  DateFormat("dd MMM, yyyy")
                      .format(orders[position].created_at),
                  style: TextStyle(
                    color: AppColors.gray,
                    fontSize: 12.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: AppDimens.cardPadding, bottom: 5),
                child: Text(
                  orders[position].service.name,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: AppDimens.cardPadding, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/person.png",
                      width: 12,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      orders[position].customer_name,
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 14.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    VerticalDivider(
                      color: AppColors.primaryColor,
                      width: 3,
                      thickness: 5,
                    ),
                    RatingBarIndicator(
                      itemCount: 5,
                      itemSize: 20,
                      rating: double.parse(
                          orders[position]?.customer?.avg_rating ?? "0"),
                      itemBuilder: (BuildContext context, _) {
                        return Icon(
                          Icons.star,
                          color: AppColors.repairingYellow,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: AppDimens.cardPadding, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/pin.png",
                      width: 12,
                      color: AppColors.primaryColor,
                    ),
                    // Icon(
                    //   Icons.location_on,
                    //   size: 15,
                    // ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(orders[position].street_no +
                        ", " +
                        orders[position].postcode +
                        " " +
                        orders[position].street_name),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: AppDimens.cardPadding, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.euro_symbol,
                      size: 15,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: AppDimens.cardPadding,
                    left: AppDimens.cardPadding,
                    bottom: AppDimens.cardPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.green.withAlpha(15),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.message,
                              color: AppColors.green,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              AppStrings.contact,
                              style: TextStyle(
                                  color: AppColors.green, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openChat(
    String chatId,
  ) async {
    await MainRouter.navigator
        .pushNamed(MainRouter.unknownScreen, arguments: chatId);
  }

  @override
  void dispose() {
    if (sub != null) sub.cancel();
    super.dispose();
  }
}
