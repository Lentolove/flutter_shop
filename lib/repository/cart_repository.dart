import 'package:flutter_shop/base/json_result.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/app_urls.dart';
import 'package:flutter_shop/model/cart_model.dart';
import 'package:flutter_shop/model/fill_in_order_model.dart';
import 'package:flutter_shop/utils/http_util.dart';

///购物车请求接口
class CartRepository {


  ///添加到购物车
  Future<JsonResult<dynamic>> addCart(Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance
          .post(AppUrls.ADD_CART, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0) {
        jsonResult.isSuccess = true;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message =
            response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      print(e);
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }

  ///查询购物车
  Future<JsonResult<CartModel>> queryCart() async {
    JsonResult<CartModel> jsonResult = JsonResult<CartModel>();
    try {
      var parameters = {
        "userId":1
      };
      var response = await HttpUtil.instance.get(AppUrls.CART_LIST,parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        jsonResult.isSuccess = true;
        CartModel cartEntity = CartModel.fromJson(response[AppStrings.DATA]);
        jsonResult.data = cartEntity;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message =
            response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      print(e.toString());
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }

  ///购物车勾选统计
  Future<JsonResult<CartModel>> cartCheck(
      Map<String, dynamic> parameters) async {
    JsonResult<CartModel> jsonResult = JsonResult<CartModel>();
    try {
      var response = await HttpUtil.instance
          .post(AppUrls.CART_CHECK, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        jsonResult.isSuccess = true;
        CartModel cartEntity = CartModel.fromJson(response[AppStrings.DATA]);
        jsonResult.data = cartEntity;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message =
            response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      print(e.toString());
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }

  ///从购物车中移除
  Future<JsonResult<CartModel>> deleteCart(
      Map<String, dynamic> parameters) async {
    JsonResult<CartModel> jsonResult = JsonResult<CartModel>();
    try {
      var response = await HttpUtil.instance
          .post(AppUrls.CART_DELETE, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        jsonResult.isSuccess = true;
        CartModel cartEntity = CartModel.fromJson(response[AppStrings.DATA]);
        jsonResult.data = cartEntity;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message =
            response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      print(e.toString());
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }

  ///更新购物车
  Future<JsonResult<dynamic>> updateCart(
      Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance
          .post(AppUrls.CART_UPDATE, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0) {
        jsonResult.isSuccess = true;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message =
            response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      print(e.toString());
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }

  ///购物车下单
  Future<JsonResult<FillInOrderModel>> cartCheckOut(
      Map<String, dynamic> parameters) async {
    JsonResult<FillInOrderModel> jsonResult = JsonResult<FillInOrderModel>();
    try {
      var response =
      await HttpUtil.instance.get(AppUrls.CART_BUY, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        FillInOrderModel fillInOrderEntity =
        FillInOrderModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = fillInOrderEntity;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message = response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      print(e.toString());
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }

  ///提交订单
  Future<JsonResult<dynamic>> submitOrder(
      Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance
          .post(AppUrls.SUBMIT_ORDER, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        jsonResult.isSuccess = true;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message = response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      print(e);
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }


}
