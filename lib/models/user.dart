class UserModel {
  String? username;
  String? useremail;
  String? userphone;
  String? status;

  UserModel(
      {this.username,
      this.useremail,
      this.userphone,
      this.status,
      });

  UserModel.fromJson(Map <String, dynamic> json){
    userphone = json["userphone"];
    useremail = json["useremail"];
    username = json["username"];
    status = json["status"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userphone"] = userphone;
    data["useremail"] = useremail;
    data["username"] = username;
    data["status"] = status;

    return data;
  }
}
