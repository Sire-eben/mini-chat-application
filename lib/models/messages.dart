class MessageModel {
  String? message;
  String? useremail;
  String? userId;

  MessageModel(
      {this.message,
      this.useremail,
      this.userId,
      });

  MessageModel.fromJson(Map <String, dynamic> json){
    message = json["message"];
    useremail = json["useremail"];
    userId = json["userId"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    data["useremail"] = useremail;
    data["userId"] = userId;

    return data;
  }
}
