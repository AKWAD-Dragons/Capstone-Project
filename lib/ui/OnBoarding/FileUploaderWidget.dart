import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/resources/strings.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/dimens.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sercl/bloc/auth/bloc.dart';
import 'dart:io';

import 'package:sercl/support/router.gr.dart';

class FileUploaderWidget extends StatefulWidget {
  @override
  FileUploaderWidget(this.title);

  final String title;

  @override
  _FileUploaderWidgetState createState() => _FileUploaderWidgetState();
}

class _FileUploaderWidgetState extends State<FileUploaderWidget> {
  StreamSubscription streamSub;
  ProfileBloc profileBloc = GetIt.instance<ProfileBloc>();
  File file;
  String fileName;
  String tempFileName;
  bool showLoading = false;

  @override
  void initState() {
    streamSub = profileBloc.subject.listen((state) {
      if (state is CompanyInfoIs) {
        setState(() {
          if(widget.title == AppStrings.businessCertificate){
            if (state.sp.businessCertFile != null) {
              file = state.sp.businessCertFile.file;
              fileName = state.sp.businessCertFile.fileName;
            } else if (state.sp.business_certificate!=null) {
              fileName = state.sp.business_certificate;
            } else {
              file = null;
              fileName = null;
            }
          }else if(widget.title == AppStrings.insurance){
            if (state.sp.insuranceFile != null) {
              file = state.sp.insuranceFile.file;
              fileName = profileBloc.sp.insuranceFile.fileName;
            }else if(state.sp.insurance!=null){
              fileName = state.sp.insurance;
            }else{
              file = null;
              fileName = null;
            }
          }else if(widget.title == AppStrings.contract){
            if (state.sp.contractFile != null) {
              file = state.sp.contractFile.file;
              fileName = profileBloc.sp.contractFile.fileName;
            }else if(state.sp.contract!=null){
              fileName = state.sp.contract;
            }else{
              file = null;
              fileName = null;
            }
          }
          // if (fileName != null) {
          //   var nameArray = file.path.split("/");
          //   fileName = nameArray[nameArray.length - 1];
          // }
          if (fileName != null) {
            var nameArray = fileName.split("/");
            fileName = nameArray[nameArray.length - 1];
          }

          showLoading = false;
        });
      }
    });

    profileBloc.dispatch(LegalScreenLaunched());
    super.initState();
  }

  @override
  void dispose() {
    streamSub.cancel();
    super.dispose();
  }

  void pickFile() async {
    setState(() {
      showLoading = true;
    });
    File tempFile = await FilePicker.getFile(type: FileType.any);
    if(tempFile == null) return;
    // print(tempFile.path);
    setState(() {
      var nameArray = tempFile.path.split("/");
      tempFileName = nameArray[nameArray.length - 1];
      fileName = nameArray[nameArray.length - 1];
    });
    print(fileName);
    if (tempFile == null) {
      setState(() {
        showLoading = false;
      });
    } else {
      profileBloc.dispatch(FilesUpdated(
          fileName: fileName, file: tempFile, addKey: widget.title));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          left: AppDimens.screenPadding,
          right: AppDimens.screenPadding,
          bottom: 10),
      child: InkWell(
        onTap: () {
          if (tempFileName == null && fileName == null) {
            pickFile();
          }
          else{
            _showModalSheet();
          }
        },
        child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: AppDimens.cardElevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.cardRadius),
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.title,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 16,
                  ),
                  DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(5),
                      padding: EdgeInsets.all(AppDimens.screenPadding),
                      color: AppColors.gray,
                      strokeWidth: 2,
                      child: Container(
                          width: double.infinity,
                          child: Column(
                            children: <Widget>[
                              Icon(
                                _fileIcon(),
                                color: file == null
                                    ? AppColors.gray
                                    : AppColors.accentColor,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                myFileName(),
                                style: TextStyle(
                                    color: file == null
                                        ? AppColors.gray
                                        : AppColors.primaryColor),
                              )
                            ],
                          ))),
                ],
              ),
            )),
      ),
    );
  }

  /* Open modal sheet for deleting a file */
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
                        pickFile();
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
                            AppStrings.editFile,
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


  IconData _fileIcon() {
    if (fileName == null && file == null) {
      return Icons.attach_file;
    } else {
      return Icons.insert_drive_file;
    }
  }

  String myFileName() {
    if (fileName == null && file == null) {
      return AppStrings.uploadFile;
    } else if (file != null) {
      var nameArray = file.path.split("/");
      return nameArray[nameArray.length - 1];
    } else if (fileName != null) {
      var nameArray = fileName.split("/");
      return nameArray[nameArray.length - 1];
    }
  }
}
