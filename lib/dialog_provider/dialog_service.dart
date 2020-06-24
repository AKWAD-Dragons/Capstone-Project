import 'dart:async';
import 'package:load/load.dart';

import 'dialog_models.dart';

class DialogService {
  Future Function(DialogModel) _showDialogListener;
  //Completer<DialogResponse> _dialogCompleter;
  void registerDialogListener(Function(DialogModel) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<dynamic> showDialog(
    DialogModel model,
  ) async {
    //_dialogCompleter = Completer<DialogResponse>();
    return _showDialogListener(model);
  }

//  void dialogComplete(DialogResponse response) {
//    _dialogCompleter.complete(response);
//    if (response.onComplete != null) response.onComplete();
//    _dialogCompleter = null;
//  }
}
