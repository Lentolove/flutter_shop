import 'package:shared_preferences/shared_preferences.dart';

///sp存储工具类
class SharedPreferencesUtil{

  static SharedPreferencesUtil get instance => _getInstance();

  static SharedPreferencesUtil? _instance;

  static SharedPreferencesUtil _getInstance() {
    _instance ??= SharedPreferencesUtil();
    return _instance!;
  }

  Future setBool(String tag, bool isFirst) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(tag, isFirst);
  }

  Future getBool(String tag) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(tag);
  }

  Future getString(String tag) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(tag);
  }

  Future<bool> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }
}