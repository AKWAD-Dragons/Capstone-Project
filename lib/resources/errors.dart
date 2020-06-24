
import 'package:sercl/PODO/LocalError.dart';
import 'package:sercl/resources/strings.dart';


class AppErrors{

  static const String _TAG_UIALERT = "UIALERT";
  static const String _TAG_SERVER= "SERVER";

  static Map<int, LocalError> _errorMap = {
   // -1: LocalError(-1,AppStrings.invalidName,"Field Error", "Error!"),
   // -2: LocalError(-2,AppStrings.invalidEmail,"Field Error", "Error!"),
   // -3: LocalError(-3,AppStrings.invalidPassword,"Field Error", "Error!"),
   // -4: LocalError(-4, AppStrings.error_noInternet, "No Internet", _TAG_UIALERT),
   // -5: LocalError(-5, AppStrings.error_profileDeleted, AppStrings.error, _TAG_UIALERT),
   // -6: LocalError(-6, AppStrings.error_accBlocked, AppStrings.error, _TAG_UIALERT),
   // -14: LocalError(-14, AppStrings.timeout_body, AppStrings.timeout, _TAG_UIALERT),
  //  500: LocalError(500,"We seem to have some technical issues and our minions are working on it", "Ouch!", _TAG_SERVER),
  };

  static get name => _errorMap[-1];
  static get email => _errorMap[-2];
  static get pass => _errorMap[-3];
  static get blocked => _errorMap[-6];

  static get confirmEmail => _errorMap[-5];

  static get en4 => _errorMap[-4];

  static get profileNotFound => _errorMap[-5];
  static get notSubmited => _errorMap[-6];

  static get en14 => _errorMap[-14];

  static get server => _errorMap[500];


}
