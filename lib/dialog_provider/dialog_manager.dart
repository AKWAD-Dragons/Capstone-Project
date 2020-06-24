import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sercl/dialog_provider/dialog_models.dart';
import 'package:ndialog/ndialog.dart';
import 'package:sercl/resources/res.dart';
import 'dialog_service.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = GetIt.instance<DialogService>();

  @override
  void initState() {
    super.initState();
    print("Dialog Manager created");
    _dialogService.registerDialogListener(_showDialogBuilder);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future _showDialogBuilder(DialogModel model) async {
    if(context == null) return;
    if (model is SuccessDialog) {
       return _showSuccessDialog(model);
    } else if (model is ErrorDialog) {
      return _showErrorDialog(model);
    }
  }

  Future _showSuccessDialog(SuccessDialog model) {
    return showDialog(
      context: context,
      builder: (b) {
        return Dialog(
            child:Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 50,
                  color: AppColors.white,
                  child: Center(
                    child: Text(
                      model.title,
                      style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  color: AppColors.primaryColor,
                  padding: EdgeInsets.only(left: AppDimens.cardPadding, right: AppDimens.cardPadding, bottom: AppDimens.cardPadding, top: AppDimens.cardPadding),
                  child: Center(
                    child: Text(
                      model.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
        );
      },
    );
  }

  Future _showErrorDialog(ErrorDialog model) {
   return showDialog(
      context: context,
      builder: (b) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 50,
                color: AppColors.white,
                child: Center(
                  child: Text(
                    model.title,
                    style: TextStyle(
                        color: AppColors.errorColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                color: AppColors.primaryColor,
                padding: EdgeInsets.only(left: AppDimens.cardPadding, right: AppDimens.cardPadding, bottom: AppDimens.cardPadding, top: AppDimens.cardPadding),
                child: Center(
                  child: Text(
                    model.message,
                    style: TextStyle(
                        color: AppColors.white
                    ),
                  ),
                ),
              )
            ],
          )
        );
      },
    );
    }
}
