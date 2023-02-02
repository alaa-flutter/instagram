import 'package:flutter/cupertino.dart';
import '../shared/enums.dart';
import '../shared_prefernces/shared_preferences.dart';

class AuthProvider  extends ChangeNotifier{
  String name_ = SharedPreferencesController().getter(type: String, key: SpKeys.username);
  String avatar_ = SharedPreferencesController().getter(type: String, key: SpKeys.avatar);
  String title_ = SharedPreferencesController().getter(type: String, key: SpKeys.title);


  Future<void> setName_(String name)async{
    name_ = name;
    await SharedPreferencesController().setter(type: String, key: SpKeys.username, value: name);
    notifyListeners();
  }


  Future<void> setAvatar_ (String avatar)async{
    avatar_ = avatar;
    await SharedPreferencesController().setter(type: String, key: SpKeys.avatar, value: avatar);
    notifyListeners();
  }

  Future<void> setTitle_ (String title)async{
    title_ = title;
    await SharedPreferencesController().setter(type: String, key: SpKeys.title, value: title);
    notifyListeners();
  }
}