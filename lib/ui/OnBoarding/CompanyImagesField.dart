import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';
import 'package:sercl/PODO/Album.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/dimens.dart';
import 'package:sercl/resources/strings.dart';
import 'package:sercl/bloc/auth/bloc.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sercl/support/router.gr.dart';

class CompanyImagesField extends StatefulWidget {
  @override
  _CompanyImagesFieldState createState() => _CompanyImagesFieldState();
}

class _CompanyImagesFieldState extends State<CompanyImagesField> {
  ProfileBloc bloc = GetIt.instance<ProfileBloc>();
  StreamSubscription sub;
  /* List of photo widgets */
  List<Widget> photoWidgets = List();

  /* List of uploaded photo files*/
  List<File> photoFiles ;

  /* Opens image picker and waits for image whether from camera or gallery */
  Future openImagePicker(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    if (image == null) {

      return;
    }
    Image one = Image.file(image);

    Album album = Album(
        image_link: (base64Encode(await image.readAsBytes())), isByte: true);
    setState(() {
      photoWidgets.add(imageContainer(album));
    });
    bloc.dispatch(CompanyImagesUpdated(album, remove: false));
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // if (!mounted) {
    //   print('NOT MOUNTED');
    //   return;
    // }
    if (bloc.sp.albums == null) return;
    this.photoWidgets = List<Widget>();
    bloc.sp.albums.forEach((image) {
      photoWidgets.add(imageContainer(image));
    });
    // if (mounted) {
    setState(() {
      photoWidgets = photoWidgets;
      photoFiles = bloc.sp.images;
    });

    sub = this.bloc.subject.listen((state) {
      if (state is CompanyInfoIs) {
        if (state.sp.albums == null) return;
        this.photoWidgets = List<Widget>();
        state.sp.albums.forEach((image) {
          photoWidgets.add(imageContainer(image));
        });
        // if (mounted) {
        setState(() {
          photoWidgets = photoWidgets;
          photoFiles = state.sp.images;
        });
        // }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (photoWidgets.length < 4 &&
        (photoWidgets.length == 0 ||
            !(photoWidgets[photoWidgets.length - 1] is InkWell))) {
      photoWidgets.add(uploaderWidget(null));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            AppStrings.addImages,
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
          child: Container(
              margin: EdgeInsets.all(AppDimens.screenPadding),
              child: Wrap(
                children: photoWidgets,
                spacing: 10,
              )),
        )
      ],
    );
  }

  Widget uploaderWidget(Album album) {
    if (album == null) {
      return InkWell(
        onTap: () async {
          // if (photoFiles.length != 4) {
            openImagePicker(ImageSource.gallery);
          //   return;
          // }
          print(photoWidgets.length);
          // Fluttertoast.showToast(
          //   msg: AppStrings.moreThanFour,
          //   toastLength: Toast.LENGTH_LONG,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIos: 1,
          //   backgroundColor: AppColors.errorColor,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
        },
        child: Container(
          width: 65,
          height: 65,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(5),
            //padding: EdgeInsets.all(AppDimens.screenPadding),
            color: AppColors.gray,
            strokeWidth: 2,
            child: Center(
                child: Image.asset(
              "assets/images/photo-camera.png",
              width: 30,
            )),
          ),
        ),
      );
    }
    Image displayImage = album.isByte != null || album.isByte
        ? Image.asset(
            "assets/images/photo-camera.png",
            width: 30,
          )
        : Image.network(album.image_link);
  }

  Widget imageContainer(Album image) {
    return GestureDetector(
        onTap: () {

        },
        onLongPress: () {
          this._showModalSheet(image);
        },
        child: Container(
            width: 65,
            height: 65,
            child: Center(
                child: image.isByte != null
                    ? image.isByte
                        ? Image.memory(base64Decode(image.image_link))
                        : Image.network(image.image_link)
                    : Image.network(image.image_link))));
  }



  /* Open modal sheet for deleting an image */
  void _showModalSheet(Album image) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 100,
            width: double.infinity,
            child: InkWell(
                onTap: () async {
                  // int index = photoFiles.indexOf(image);

                  // photoWidgets.removeAt(index);
                  // Album album = Album(isByte: true,image_link: base64Encode() )
                  MainRouter.navigator.pop(context);
                  bloc.dispatch(CompanyImagesUpdated(image, remove: true));
                },
                child: Center(
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
                )),
          );
        });
  }
}
