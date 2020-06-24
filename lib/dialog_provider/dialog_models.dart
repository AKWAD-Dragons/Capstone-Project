abstract class DialogModel {}

class ErrorDialog extends DialogModel {
  String message;
  String title;
  String code;
  ErrorDialog({this.message, this.title = 'Error', this.code});
}

class SuccessDialog extends DialogModel {
  String title;
  String message;
  SuccessDialog({this.title = 'Success', this.message});
}

class DialogResponse {
  bool response;
  Function() onComplete = () {};
  DialogResponse({this.response = false, this.onComplete});
}
