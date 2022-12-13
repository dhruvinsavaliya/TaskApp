import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SharedPrefutils{

  static GetStorage getStorage = GetStorage();

  static String isLogin = "isLogin";
  static String token = "token";

  static Future setLogin(String value) async{
    await getStorage.write(isLogin, value);
  }
  static  getLogin() {
    return getStorage.read(isLogin) ?? "";
  }

  static Future setToken(String? value) async{
    await getStorage.write(token, value);
  }
  static  getToken() {
    return getStorage.read(token) ?? "";
  }
}
