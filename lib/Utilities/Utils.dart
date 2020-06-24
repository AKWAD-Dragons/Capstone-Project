import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:load/load.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sercl/PODO/LocalError.dart';
import 'package:sercl/bloc/ErrorBloc.dart';
import 'package:sercl/resources/errors.dart';
import 'NetworkConnectivityChecker.dart';

//Function that handles all basic internet requests
//by handles its errors and show Loading...
Future<void> netFunc(Function fun, {bool showLoading = true}) async {
  if (showLoading)
    Future.delayed(Duration(milliseconds: 100), () {
      showLoadingDialog(tapDismiss: false);
    });

  ErrorBloc.clear();
  try {
    bool isConnected = await NetworkConnectivityChecker.isConnected();
    if (!isConnected) {
      throw AppErrors.en4;
    }

    await fun();
  } catch (e) {
    if (e is LocalError) {
      ErrorBloc.push(e);
    } else {
      ErrorBloc.push(LocalError(0, e.toString(), "", "Server!"));
    }
  } finally {
    if (showLoading) {
      Future.delayed(Duration(milliseconds: 100), () {
        hideLoadingDialog();
      });
    }
  }
}

class AppUtils {
  int countWords(String string) {
    String currentAnswer = string.trim();

    int counter = 0;
    for (int i = 0; i < currentAnswer.length; i++) {
      if ((currentAnswer[i].trim() != "" && counter == 0) ||
          (currentAnswer[i].trim() != "" && currentAnswer[i - 1] == " ")) {
        counter++;
      }
    }
    return counter;
  }

  Future<File> compressToFit(File file) async {
    Directory dir = await getTemporaryDirectory();
    String targetPath = dir.absolute.path + "/temp.jpg";
    while (file != null && bToMb(file.lengthSync()) > 2) {
      file = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path, targetPath,
          quality: 40);
    }
    return file;
  }

  double bToMb(int byte) {
    return (byte / (1000 * 1000));
  }

  bool validEmail(String value) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }
}
