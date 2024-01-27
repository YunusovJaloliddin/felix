import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../models/user_model.dart';
import '../storage/storage.dart';

class ProjectModel extends ChangeNotifier {
  Locale locale = const Locale("uz");
  String dropDownValue = "uz";
  UserModel? userModel;

  void setUser(UserModel user) async {
    userModel = user;
    await $secureStorage.write(
      key: StorageKeys.user.key,
      value: jsonEncode(user),
    );
    notifyListeners();
  }

  Future<void> getUser()async{
    String path=await $secureStorage.read(key: StorageKeys.user.key) ?? "";
    if(path!=""){
      userModel = UserModel.fromJson(jsonDecode(path));
    }
    notifyListeners();
  }

  void setLocale(Locale locales, String set) async {
    locale = locales;
    await $secureStorage.write(
        key: StorageKeys.locale.key, value: locale.languageCode);
    dropDownValue = set;
    notifyListeners();
  }

  void getLocale() async {
    String? languageCod =
        await $secureStorage.read(key: StorageKeys.locale.key);
    locale = Locale(languageCod ?? "uz");
    dropDownValue = locale.languageCode;
    notifyListeners();
  }
}
