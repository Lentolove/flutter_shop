import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/utils/shared_preferences_util.dart';

class UserViewModel extends BaseViewModel {
  bool _showTitle = false;

  String? _pictureUrl;
  String? _userName = "我是小xxx";
  int _collectionNumber = 0;
  int _footPrintfNumber = 0;
  int _couponNumber = 0;
  int _page = 1;
  int _limit = 20;
  bool _isFirst = true;

  bool get showTitle => _showTitle;

  String? get pictureUrl => _pictureUrl;

  String? get userName => _userName;

  int get footPrintfNumber => _footPrintfNumber;

  int get couponNumber => _couponNumber;

  int get collectionNumber => _collectionNumber;

  String? text;

  bool get isFirst => _isFirst;

  //刷新用户状态
  refreshData() async {
    String? token;
    await SharedPreferencesUtil.instance
        .getString(AppStrings.TOKEN)
        .then((value) => token = value);
    if (token != null && token!.isNotEmpty) {
      await SharedPreferencesUtil.instance
          .getString(AppStrings.NICK_NAME)
          .then((value) => _userName = value);
      await SharedPreferencesUtil.instance
          .getString(AppStrings.HEAD_URL)
          .then((value) => _pictureUrl = value);

      await SharedPreferencesUtil.instance
          .getBool(AppStrings.IS_FIRST)
          .then((value) {
        _isFirst = value ??= true;
      });
      // await _queryCoupon();
      // await _queryFootPrint();
      // await _queryCollection();
      notifyListeners();
    }
  }
}
