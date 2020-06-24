import 'package:flutter/material.dart';
import 'package:sercl/resources/res.dart';

class ChangeLangDialog extends StatefulWidget {
  const ChangeLangDialog();

  @override
  _ChangeLangDialogState createState() => _ChangeLangDialogState();
}

class _ChangeLangDialogState extends State<ChangeLangDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: AppDimens.screenPadding, bottom: AppDimens.screenPadding),
            child: Text(
              AppStrings.changeLang,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: AppColors.primaryColor,height: 0.5,),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    AppStrings.setCurrentLocal(AppStrings.en_code);
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Image.asset(
                              "assets/images/e_flag.png",
                              height: 20,
                            ),
                          ),
                          Text(
                            AppStrings.English,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              Container(
                height: 55,
                width: 0.5,
                color: AppColors.primaryColor,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    AppStrings.setCurrentLocal(AppStrings.de_code);
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Image.asset(
                              "assets/images/g_flag.png",
                              height: 20,
                            ),
                          ),
                          Text(
                            AppStrings.Deutsche,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
