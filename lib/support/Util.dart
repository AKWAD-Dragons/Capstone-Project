import 'dart:convert';
import 'dart:io';

class Util {
  static Future<String> stringFromFile(File file) async {
    if(file != null){List<int> bytes = await file.readAsBytes();
    return base64Encode(bytes);};
    
  }

  static String dateTimeToString(DateTime dt, {bool date}) {
    String st = dt.toString();
    st = st.replaceRange(st.indexOf("."), st.length, "");
    if(date == true){
      st = st.substring(0,st.indexOf(" "));
    }else if (date == false) {
      st = st.substring(st.indexOf(" ")+1, st.length);
    }//else is date == null
    return st;
  }
}
