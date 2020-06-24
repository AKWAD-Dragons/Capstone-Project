import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sercl/PODO/SP.dart';
import 'package:sercl/bloc/profile/bloc.dart';
import 'package:sercl/resources/res.dart';
import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:sercl/bloc/orders/bloc.dart';
import 'package:sercl/PODO/Invitation.dart';
import 'package:sercl/support/router.gr.dart';

class InvitationsList extends StatefulWidget {
  @override
  _InvitationsListState createState() => _InvitationsListState();
}

class _InvitationsListState extends State<InvitationsList> {
  StreamSubscription<OrdersState> sub;
  List<Invitation> invitations;
  final OrdersBloc _ordersBloc = GetIt.instance<OrdersBloc>();
  Map<String, String> statuses = {
    CodeStrings.inv_pending: AppStrings.s_pending,
    CodeStrings.inv_accepted: AppStrings.s_accepted,
    CodeStrings.inv_status_completed: AppStrings.s_completed,
    CodeStrings.inv_unavailable: AppStrings.s_unavailable,
    CodeStrings.inv_cancelled: AppStrings.s_cancelled,
    CodeStrings.inv_closed: AppStrings.s_closed,
  };

  /* used to avoid showing empty state while invitations are still loading */
  bool showEmptyView = false;
  ProfileBloc _profileBloc = GetIt.instance<ProfileBloc>();

  //ChatBloc _chatBloc = GetIt.instance<ChatBloc>();
  StreamSubscription profileSub;
  SP sp;

  @override
  void initState() {
    sub = _ordersBloc.ordersStateSubject.listen((receivedState) {
      if (receivedState is InvitationsAreAfterRejection) {
        showRejectedToast();
        setInvitations(receivedState.invitations);
      }
    });
    profileSub = _profileBloc.subject.listen((state) {
      if (state is CompanyInfoIs) {
        setState(() {
          sp = state.sp;
        });
      }
    });
    _profileBloc.dispatch(HomePageLaunched());
    _ordersBloc.dispatch(InvitationsTabClicked());

    super.initState();
  }

  void setInvitations(List<Invitation> invs) {
    if (invs == null) return;
    if (mounted) {
      setState(() {
        invitations = invs;
        if (invitations == null || invitations.length == 0)
          showEmptyView = true;
        else
          showEmptyView = false;
      });
    }
  }

  void showRejectedToast() {
    Fluttertoast.showToast(
      msg: AppStrings.invitationRejected,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      textColor: Colors.white,
      fontSize: 16.0,
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
                itemCount: invitations == null ? 0 : invitations.length,
                itemBuilder: (BuildContext context, int index) =>
                    invitationItem(context, invitations.length - 1 - index),
              ),
      ),
    );
  }

  Widget emptyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          "assets/images/no_chats.png",
          width: 100,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          AppStrings.noInvitations,
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
            AppStrings.noInvitationsMsg,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.grayText),
          ),
        )
      ],
    );
  }

  Widget invitationItem(BuildContext context, int position) {
    return InkWell(
      onTap: () async {
        ///TODO: Dispatch invitation item selection event
        ///TODO: Navigate to invitation details screen
        _ordersBloc.dispatch(InvitationsTabClicked());

        print('INVITATION ====> ${invitations[position].id}');
      },
      child: Card(
        elevation: AppDimens.cardElevation,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.cardRadius)),
        child: Container(
          margin: EdgeInsets.only(top: 16, right: 10, left: 0, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: AppDimens.cardPadding, bottom: 5),
                child: Text(
                  DateFormat("dd MMM, yyyy")
                      .format(invitations[position].request.created_at),
                  style: TextStyle(
                    color: AppColors.gray,
                    fontSize: 12.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: AppDimens.cardPadding, bottom: 5),
                      child: Text(
                        invitations[position].request.service.name,
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: AppDimens.cardPadding),
                    padding: EdgeInsets.all(AppDimens.statusCardPadding),
                    child: Text(
                      statuses[invitations[position].status.toString()],
                      style: TextStyle(
                          color: AppColors.accentColor, fontSize: 10.0),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.accentColor,
                      ),
                      borderRadius:
                          BorderRadius.circular(AppDimens.statusCardRadius),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: AppDimens.cardPadding, bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/user.png",
                      width: 13,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      invitations[position].request.customer.name,
                      style: TextStyle(fontSize: 13.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 13.0, color: AppColors.border),
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingBarIndicator(
                      itemCount: 5,
                      itemSize: 20,
                      rating: double.parse(
                          invitations[position].request.customer.avg_rating ??
                              "0"),
                      itemBuilder: (BuildContext context, _) {
                        return Icon(
                          Icons.star,
                          color: AppColors.starYellow,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: AppDimens.cardPadding, bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/pin.png",
                      width: 13,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        invitations[position].request.address.street_name +
                            " " +
                            invitations[position]
                                .request
                                .address
                                .street_number +
                            " ," +
                            invitations[position].request.address.postal_code,
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ],
                ),
              ),
              invitations[position].request.date != null
                  ? Container(
                      margin: EdgeInsets.only(
                          left: AppDimens.cardPadding, bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              AppStrings.visitDate +
                                  ": " +
                                  DateFormat("dd MMM").format(
                                      invitations[position].request.date),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.errorColor.withAlpha(15),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.clear,
                            color: AppColors.errorColor,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppStrings.reject,
                            style: TextStyle(
                                color: AppColors.errorColor, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      //Reject invitation
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      //Contact customer for this invitation
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
                            style:
                                TextStyle(color: AppColors.green, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (sub != null) sub.cancel();
    profileSub.cancel();
    super.dispose();
  }
}
