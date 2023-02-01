import 'package:flutter/cupertino.dart';
import '../shared/enums.dart';
import '../shared_prefernces/shared_preferences.dart';
class LangProviders extends ChangeNotifier {
  String lang_ = SharedPreferencesController().getter(type: String, key: SpKeys.language).toString();

  Future<void> changeLanguage() async {
    lang_ == 'ar' ? lang_ = 'en' : lang_ = 'ar';

    /// if( lang_ == 'ar'){
    /// lang_ = 'en'
    /// }else{
    /// lang_ = 'ar'
    /// }


    await SharedPreferencesController().setter(type: String, key: SpKeys.language, value: lang_);
    notifyListeners();
  }
}
