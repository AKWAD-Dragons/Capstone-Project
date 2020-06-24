import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/resources/strings.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/dimens.dart';
import 'package:flutter/material.dart';

import 'package:sercl/PODO/Area.dart';

class MyAreasList extends StatefulWidget {
  @override
  _MyAreasListState createState() => _MyAreasListState();
}

class _MyAreasListState extends State<MyAreasList> {
  List<Widget> areas = List();

  ProfileBloc bloc = GetIt.instance<ProfileBloc>();
  StreamSubscription sub;
  @override
  void initState() {
    sub = bloc.subject.listen((ProfileState state) {
      if (state is CompanyInfoIs) {
        setState(() {
          areas.clear();
          for (int i = 0; i < state.sp.areas.length ?? 0; i++) {
            if (state.sp.deletedAreas.contains(state.sp.areas[i])) {
              continue;
            }
            areas.add(singleArea(state.sp.areas[i]));
          }
          for (int i = 0; i < state.sp.addedAreas.length ?? 0; i++) {
            areas.add(singleArea(state.sp.addedAreas[i]));
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    this.sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppDimens.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.myCodes,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AppDimens.screenPadding,
          ),
          Wrap(spacing: 5, children: areas),
          Center(
            child: Visibility(
                visible: areas.isEmpty,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/images/no_areas_faded.png",
                      width: 150,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppStrings.noAreas,
                      style: TextStyle(color: AppColors.gray),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget singleArea(Area area) {
    return Chip(
      onDeleted: () {
        bloc.dispatch(AreaUpdated(area, true));
      },
      label: Text(AppStrings.from+': ' + area.from + ' , '+AppStrings.to+  ': ' + area.to),
      backgroundColor: AppColors.lightBackground,
      deleteIcon: Icon(Icons.close),
      deleteIconColor: AppColors.errorColor,
    );
  }
}
