import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/repository/mine_repository.dart';
import 'package:flutter_shop/utils/shared_preferences_util.dart';

class UserViewModel extends BaseViewModel {
  final MineRepository _mineRepository = MineRepository();

  final bool _showTitle = false;

  String? _pictureUrl;
  String? _userName = "我是小xxx";
  int _collectionNumber = 0;
  int _footPrintfNumber = 0;
  int _couponNumber = 0;
  final int _page = 1;
  final int _limit = 20;
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
    print("refreshData : token = $token");
    if (token != null && token!.isNotEmpty) {
      await SharedPreferencesUtil.instance
          .getString(AppStrings.NICK_NAME)
          .then((value) => _userName = value);

      await SharedPreferencesUtil.instance
          .getString(AppStrings.HEAD_URL)
          .then((value) => _pictureUrl = value);
      await _queryCoupon();
      await _queryFootPrint();
      await _queryCollection();
      await SharedPreferencesUtil.instance
          .getBool(AppStrings.IS_FIRST)
          .then((value) {
        print("refreshData == $value");
        _isFirst = value ??= true;
      });
      notifyListeners();
    } else {
      await SharedPreferencesUtil.instance
          .getBool(AppStrings.IS_FIRST)
          .then((value) {
        print("refreshData == $value");
        _isFirst = value ??= true;
      });
      notifyListeners();
    }
  }

  ///查询优惠券
  _queryCoupon() async {
    var couponParameters = {
      AppParameters.PAGE: _page,
      AppParameters.LIMIT: _limit
    };
    await _mineRepository
        .queryCoupon(couponParameters)
        .then((value) => _couponNumber = value.data?.total ?? 0);
  }

  ///更新用户信息
  setUserInformation(String picture, String userName) {
    _pictureUrl = pictureUrl;
    _userName = userName;
  }

  ///查询收藏
  _queryCollection() async {
    var collectionParameters = {
      AppParameters.TYPE: 0,
      AppParameters.PAGE: 1,
      AppParameters.LIMIT: 1000
    };
    await _mineRepository
        .queryCollect(collectionParameters)
        .then((value) => _collectionNumber = value.data?.total ?? 0);
  }

  ///查询足迹
  _queryFootPrint() async {
    var footPrintParameters = {
      AppParameters.PAGE: _page,
      AppParameters.LIMIT: _limit
    };
    await _mineRepository
        .queryFootPrint(footPrintParameters)
        .then((value) => _footPrintfNumber = value.data?.total ?? 0);
  }

  collectionDataChange() {
    _queryCollection();
    notifyListeners();
  }

  footPrintDataChange() {
    _queryFootPrint();
  }
}
