import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/coupon_model.dart';
import 'package:flutter_shop/repository/mine_repository.dart';

//优惠券
class CouponViewModel extends BaseViewModel{

  final MineRepository _mineRepository = MineRepository();

  CouponModel? _couponModel;

  bool _canLoadMore = false;

  final List<CouponItem> _couponList = [];

  CouponModel? get couponModel => _couponModel;

  bool get canLoadMore => _canLoadMore;

  List<CouponItem> get couponList => _couponList;

  //查询优惠券列表
  queryCoupon(int pageIndex, int limit) {
    var parameters = {AppParameters.PAGE: pageIndex, AppParameters.LIMIT: limit};
    _mineRepository.queryCoupon(parameters).then((response) {
      if (response.isSuccess) {
        _couponModel = response.data;
        if (pageIndex == 1) {
          _couponList.clear();
        }
        _couponList.addAll(response.data?.xList ??  []);
        _canLoadMore = _couponList.length < _couponModel!.total!;
        pageState = _couponList.isEmpty ? PageState.empty : PageState.hasData;
        notifyListeners();
      } else {
        errorNotify(response.message);
      }
    });
  }
}