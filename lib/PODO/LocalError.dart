class LocalError implements Exception{
  int code;
  String msg;
  String title;
  String tag;

  LocalError(this.code, this.msg, this.title, this.tag);


  static LocalError fromJson(Map<String,dynamic> json) => LocalError(
      json['code'],
      json['msg'],
      json['title'],
      json['tag']
  );

}