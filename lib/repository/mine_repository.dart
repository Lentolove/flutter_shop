import 'package:flutter_shop/base/json_result.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/app_urls.dart';
import 'package:flutter_shop/model/address_model.dart';
import 'package:flutter_shop/model/collection_model.dart';
import 'package:flutter_shop/model/coupon_model.dart';
import 'package:flutter_shop/model/foot_print_model.dart';
import 'package:flutter_shop/model/order_detail_model.dart';
import 'package:flutter_shop/model/order_list_model.dart';
import 'package:flutter_shop/utils/http_util.dart';

///个人数据操作
class MineRepository {

  ///收藏或者取消收藏
  Future<JsonResult<dynamic>> addOrDeleteCollect(
      Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance.post(
        AppUrls.COLLECT_ADD_DELETE,
        parameters: parameters,
      );
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

  ///查询收藏
  Future<JsonResult<CollectionModel>> queryCollect(
      Map<String, dynamic> parameters) async {
    JsonResult<CollectionModel> jsonResult = JsonResult<CollectionModel>();
    try {
      var response = await HttpUtil.instance
          .get(AppUrls.MINE_COLLECT, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        CollectionModel collectModel =
        CollectionModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = collectModel;
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

  ///获取地址列表
  Future<JsonResult<AddressModel>> getAddressList() async {
    JsonResult<AddressModel> jsonResult = JsonResult<AddressModel>();
    try {
      var response = await HttpUtil.instance.get(AppUrls.ADDRESS_LIST);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        AddressModel addressModel =
        AddressModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = addressModel;
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

  ///查询地址详情
  Future<JsonResult<AddressItem>> queryAddressDetail(
      Map<String, dynamic> parameters) async {
    JsonResult<AddressItem> jsonResult = JsonResult<AddressItem>();
    try {
      var response = await HttpUtil.instance
          .get(AppUrls.ADDRESS_DETAIL, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        AddressItem addressItem =
        AddressItem.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = addressItem;
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

  ///删除地址
  Future<JsonResult<dynamic>> deleteAddress(
      Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance
          .post(AppUrls.ADDRESS_DELETE, parameters: parameters);
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

  ///添加地址
  Future<JsonResult<dynamic>> addAddress(
      Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance
          .post(AppUrls.ADDRESS_SAVE, parameters: parameters);
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

  ///查询订单列表
  Future<JsonResult<OrderListModel>> queryOrder(
      Map<String, dynamic> parameters) async {
    JsonResult<OrderListModel> jsonResult = JsonResult<OrderListModel>();
    try {
      var response = await HttpUtil.instance.get(
        AppUrls.MINE_ORDERS,
        parameters: parameters,
      );
      if (response[AppStrings.ERR_NO] == 0) {
        jsonResult.isSuccess = true;
        OrderListModel model = OrderListModel.fromJson(response[AppStrings.DATA]);
        jsonResult.data = model;
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


  ///查询订单详情
  Future<JsonResult<OrderDetailModel>> queryOrderDetail(
      Map<String, dynamic> parameters) async {
    JsonResult<OrderDetailModel> jsonResult = JsonResult<OrderDetailModel>();
    try {
      var response = await HttpUtil.instance.get(
        AppUrls.MINE_ORDER_DETAIL,
        parameters: parameters,
      );
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        OrderDetailModel model =
        OrderDetailModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = model;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message = response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }

  ///删除订单
  Future<JsonResult<dynamic>> deleteOrder(
      Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance.post(
        AppUrls.MINE_ORDER_DELETE,
        parameters: parameters,
      );
      if (response[AppStrings.ERR_NO] == 0) {
        jsonResult.isSuccess = true;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message = response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }

  ///取消订单
  Future<JsonResult<dynamic>> cancelOrder(
      Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance.post(
        AppUrls.MINE_ORDER_CANCEL,
        parameters: parameters,
      );
      if (response[AppStrings.ERR_NO] == 0) {
        jsonResult.isSuccess = true;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message = response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }



  ///我的优惠券
  Future<JsonResult<CouponModel>> queryCoupon(
      Map<String, dynamic> parameters) async {
    JsonResult<CouponModel> jsonResult = JsonResult<CouponModel>();
    try {
      var response = await HttpUtil.instance
          .get(AppUrls.MINE_COUPON_LIST, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        CouponModel model =
        CouponModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = model;
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

  ///领取优惠券
  Future<JsonResult<dynamic>> receiveCoupon(
      Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance
          .post(AppUrls.RECEIVE_COUPON, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        jsonResult.isSuccess = true;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message = response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }


  /// 足迹
  Future<JsonResult<FootPrintModel>> queryFootPrint(
      Map<String, dynamic> parameters) async {
    JsonResult<FootPrintModel> jsonResult = JsonResult<FootPrintModel>();
    try {
      var response = await HttpUtil.instance.get(
        AppUrls.MINE_FOOTPRINT,
        parameters: parameters,
      );
      if (response[AppStrings.ERR_NO] == 0) {
        FootPrintModel model =
        FootPrintModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = model;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message = response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }

  ///删除足迹
  Future<JsonResult<dynamic>> deleteFootPrint(
      Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance.post(
        AppUrls.MINE_FOOTPRINT_DELETE,
        parameters: parameters,
      );
      if (response[AppStrings.ERR_NO] == 0) {
        jsonResult.isSuccess = true;
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message = response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }


  ///快速购买
  Future<JsonResult<dynamic>> buy(Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance.post(
        AppUrls.FAST_BUY,
        parameters: parameters,
      );
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        jsonResult.isSuccess = true;
        jsonResult.data = response[AppStrings.DATA];
      } else {
        jsonResult.isSuccess = false;
        jsonResult.message = response[AppStrings.ERR_MSG] ?? AppStrings.SERVER_EXCEPTION;
      }
    } catch (e) {
      jsonResult.isSuccess = false;
      jsonResult.message = AppStrings.SERVER_EXCEPTION;
    }
    return jsonResult;
  }

}
