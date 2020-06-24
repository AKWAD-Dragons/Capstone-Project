import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/bloc/profile/profile_bloc.dart';
import 'package:sercl/bloc/profile/profile_event.dart';
import 'package:sercl/bloc/profile/profile_state.dart';
import 'package:sercl/resources/res.dart';
import 'package:string_validator/string_validator.dart';

import 'ScreenHeader.dart';

class BillingInfoScreen extends StatefulWidget {
  @override
  _BillingInfoScreenState createState() => _BillingInfoScreenState();
}

class _BillingInfoScreenState extends State<BillingInfoScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController streetNameController = TextEditingController();
  TextEditingController streetNumberController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController bicController = TextEditingController();
  TextEditingController taxIdController = TextEditingController();
  bool isSmallCompany = true;

  ProfileBloc _profileBloc = GetIt.instance<ProfileBloc>();
  StreamSubscription sub;

  @override
  void initState() {
    sub = _profileBloc.subject.listen((profileState) {
      if (profileState is SPBillingInfoIs) {
        setState(() {
          streetNameController.text = profileState.streetName;
          streetNumberController.text =
              profileState.streetNumber?.toString() ?? null;
          postalCodeController.text = profileState.postalCode?.toString() ?? null;
          cityController.text = profileState.city;
          phoneController.text = profileState.phone;
          ibanController.text = profileState.iban?.toString() ?? null;
          bicController.text = profileState.bic?.toString() ?? null;
          taxIdController.text = profileState.taxId?.toString() ?? null;
          isSmallCompany = profileState?.isSmallCompany ?? true;
        });
      }
    });
    _profileBloc.dispatch(BillingInfoScreenLaunched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if (!submitClicked) {
        //   profileBloc.dispatch(ServicesSelected(null, cancel: true));
        // }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ScreenHeader(AppStrings.billingInfoTitle),
              // Expanded(
              //     child: ListView.builder(
              //         padding: EdgeInsets.only(top: 16, bottom: 16),
              //         itemCount: categories.length,
              //         itemBuilder: (BuildContext context, int i) {
              //           return singleCategory(
              //               categories[i], i == 0 ? true : false);
              //         })),

              Expanded(
                child: SingleChildScrollView(
                    child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      title(AppStrings.address),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: textField(
                              streetNameController,
                              AppStrings.streetName,
                              AppStrings.streetNameRequired,
                              false,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: textField(
                              streetNumberController,
                              AppStrings.streetNumber,
                              AppStrings.streetNumberRequired,
                              true,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: textField(
                              postalCodeController,
                              AppStrings.postalCode,
                              AppStrings.postalCodeRequired,
                              true,
                              max: 5,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: textField(
                              cityController,
                              AppStrings.city,
                              AppStrings.cityRequired,
                              false,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      title(AppStrings.phoneNumber),
                      textField(
                        phoneController,
                        AppStrings.companyPhoneNumber,
                        AppStrings.companyPhoneNumberRequired,
                        true,
                      ),
                      SizedBox(height: 30),
                      title(AppStrings.accountInfo),
                      textField(
                        ibanController,
                        AppStrings.iban,
                        AppStrings.ibanRequired,
                        false,
                      ),
                      textField(
                        bicController,
                        AppStrings.bic,
                        AppStrings.bicRequired,
                        false,
                      ),
                      title(AppStrings.taxId,
                          subtitle: AppStrings.taxIdSubtitle),
                      textField(taxIdController, AppStrings.taxId,
                          AppStrings.taxIdRequired, false,
                          validator: isSmallCompany
                              ? (val)=>null
                              : (String value) {
                                  value = value.trim();
                                  if (value.isEmpty)
                                    return AppStrings.taxIdRequired;
                                  return null;
                                }),
                      SizedBox(height: 40),
                    ],
                  ),
                )),
              ),

              nextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget title(String text, {String subtitle}) {
    return Container(
      margin: EdgeInsets.only(
          left: AppDimens.screenPadding, top: AppDimens.screenPadding),
      child: Wrap(
        children: <Widget>[
          Text(
            text + " ",
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          subtitle != null
              ? Text(
                  subtitle,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget textField(
      TextEditingController controller, String hint, String error, bool numeric,
      {int max = 99, String validator(String value)}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          TextFormField(
            maxLength: max,
            controller: controller,
            keyboardType: numeric ? TextInputType.number : TextInputType.text,
            validator: (value) {
              if (validator != null) {
                return validator(value);
              }
              if (value.trim().isEmpty) return error;
              if (numeric && !isNumeric(value.trim()))
                return AppStrings.invalidCharacters;
              return null;
            },
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: AppColors.hint, fontSize: 16)),
          )
        ],
      ),
    );
  }

  Widget nextButton() {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        bool validated = formKey.currentState.validate();
        if (validated) {
          this._profileBloc.dispatch(BillingInfoUpdated(
                streetNameController.text,
                streetNumberController.text,
                postalCodeController.text,
                cityController.text,
                phoneController.text,
                ibanController.text,
                bicController.text,
                taxIdController.text,
              ));
          this._profileBloc.dispatch(SaveButtonTaped(4));
        }
      },
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50))),
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.only(bottom: 20),
          child: Container(
            padding: EdgeInsets.only(
                left: AppDimens.buttonPadding, right: AppDimens.buttonPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    AppStrings.saveAndContinue,
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Image.asset(
                  "assets/images/forward.png",
                  width: 20,
                  height: 20,
                )
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
