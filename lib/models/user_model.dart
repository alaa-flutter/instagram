

class UserModel {
  late String uId;
  late String username;
  late String email;
  late String password;
  late String avatar;
  late String fcmToken;


  UserModel();

  UserModel.fromMap(Map<String, dynamic> map) {
    uId = map['uId'];
    username = map['username'];
    email = map['email'];
    password = map['password'];
    avatar = map['avatar'];
    fcmToken = map['fcmToken'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['uId'] = uId;
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['avatar'] = avatar;
    map['fcmToken'] = fcmToken;
    return map;
  }
}
