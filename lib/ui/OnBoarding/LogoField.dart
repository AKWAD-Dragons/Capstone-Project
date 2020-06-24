import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/dimens.dart';
import 'package:sercl/resources/strings.dart';
import 'package:sercl/bloc/auth/bloc.dart';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sercl/support/router.gr.dart';

class LogoField extends StatefulWidget {
  @override
  _LogoFieldState createState() => _LogoFieldState();
}

class _LogoFieldState extends State<LogoField> {
  Image _logoImage;
  StreamSubscription state;
  ProfileBloc bloc = GetIt.instance<ProfileBloc>();

  @override
  void initState() {
    state = bloc.subject.listen((profileState) {
      if (!(profileState is CompanyInfoIs)) {
        return;
      }
      CompanyInfoIs state = profileState;
      if (state.sp.logo != null) {
        _logoImage = Image.file(
          state.sp.logo,
          fit: BoxFit.cover,
        );
      } else if (state.sp.logo_link != null) {
        _logoImage = Image.network(
          state.sp.logo_link,
          fit: BoxFit.cover,
        );
      }
      setState(() {
        _logoImage = _logoImage;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    this.state.cancel();
    super.dispose();
  }

  Future getLogoImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    bloc.dispatch(CompanyLogoUpdated(image));
  }

  Future deleteLogoImage() async {
    setState(() {
      _logoImage = null;
    });
    bloc.dispatch(CompanyLogoUpdated(null));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            AppStrings.companyLogo,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          margin: EdgeInsets.only(bottom: 10),
        ),
        Card(
          color: AppColors.white,
          elevation: 3,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(AppDimens.screenPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: _logoImage == null,
                      child: InkWell(
                        onTap: () {
                          getLogoImage();
                        },
                        child: Container(
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(5),
                            padding: EdgeInsets.all(AppDimens.screenPadding),
                            color: AppColors.gray,
                            strokeWidth: 2,
                            child: Image.asset(
                              "assets/images/photo-camera.png",
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _logoImage != null,
                      child: InkWell(
                        onTap: () {
                          _showModalSheet();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.gray,
                          ),
                          height: 70,
                          width: 70,
                          child: _logoImage == null
                              ? Container(
                                  height: 0,
                                )
                              : Container(
                                  child: _logoImage,
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  /* Open modal sheet for deleting an image */
  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 100,
            width: double.infinity,
            child: Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        MainRouter.navigator.pop(context);
                        getLogoImage();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.edit,
                            color: AppColors.green,
                            size: 30,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            AppStrings.editImage,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: AppColors.lightBackground,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        MainRouter.navigator.pop(context);
                        deleteLogoImage();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.delete_outline,
                            color: AppColors.errorColor,
                            size: 30,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            AppStrings.removeImage,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
