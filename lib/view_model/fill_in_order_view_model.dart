import 'dart:convert';

import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/fill_in_order_model.dart';
import 'package:flutter_shop/repository/cart_repository.dart';
import 'package:flutter_shop/repository/goods_repository.dart';
import 'package:flutter_shop/utils/toast_util.dart';

//提交订单 ViewModel
class FillInOrderViewModel extends BaseViewModel {
  final CartRepository _cartRepository = CartRepository();

  //提交订单的数据模型
  FillInOrderModel? _fillInOrderModel;

  //提交订单的地址
  FillInOrderCheckedAddress? _fillInOrderCheckedAddress;

  FillInOrderModel? get fillInOrderModel => _fillInOrderModel;

  FillInOrderCheckedAddress? get fillInOrderCheckAddress =>
      _fillInOrderCheckedAddress;

  queryFillInOrderData(int cardId) {
    var parameters = {
      AppParameters.CART_ID: cardId,
      AppParameters.ADDRESS_ID: 0,
      AppParameters.COUPON_ID: 0,
      AppParameters.GROUPON_RULES_ID: 0,
    };
    _cartRepository.cartCheckOut(parameters).then((response) {
      if (response.isSuccess) {
        _fillInOrderModel = response.data;
        _fillInOrderCheckedAddress = fillInOrderModel!.checkedAddress;
        pageState =
            fillInOrderModel == null ? PageState.empty : PageState.hasData;
        notifyListeners();
      } else {
        ToastUtil.showToast(response.message);
      }
    });
  }

  //更新地址
  updateAddress(var address) {
    print((jsonDecode(Uri.decodeComponent(address))));
    _fillInOrderCheckedAddress = FillInOrderCheckedAddress.fromJson(
        (jsonDecode(Uri.decodeComponent(address))));
    notifyListeners();
  }

  ///提交订单
  Future<bool> submitOrder(
      int cartId, int addressId, String message, int couponId) async {
    bool isResult = false;
    var parameters = {
      AppParameters.CART_ID: cartId,
      AppParameters.ADDRESS_ID: addressId,
      AppParameters.MESSAGE: message,
      AppParameters.COUPON_ID: couponId,
      AppParameters.GROUPON_RULES_ID: 0,
      AppParameters.GROUPON_LINK_ID: 0
    };
    await _cartRepository.submitOrder(parameters).then((response) {
      isResult = response.isSuccess;
      if (!response.isSuccess) {
        ToastUtil.showToast(response.message);
      }
    });
    return isResult;
  }
}
