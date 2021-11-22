import 'package:flutter_shop/base/json_result.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/app_urls.dart';
import 'package:flutter_shop/model/category_goods_model.dart';
import 'package:flutter_shop/model/good_detail_model.dart';
import 'package:flutter_shop/model/search_good_model.dart';
import 'package:flutter_shop/utils/http_util.dart';

class GoodsRepository {
  ///获取分类下的商品信息
  Future<JsonResult<CategoryGoodsListModel>> getCategoryGoodsList(
      Map<String, dynamic> parameters) async {
    JsonResult<CategoryGoodsListModel> jsonResult =
        JsonResult<CategoryGoodsListModel>();
    try {
      var response = await HttpUtil.instance
          .get(AppUrls.GOODS_LIST_URL, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        CategoryGoodsListModel categoryGoodsEntity =
            CategoryGoodsListModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = categoryGoodsEntity;
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

  ///获取商品详情
  Future<JsonResult<GoodDetailModel>> getGoodsDetailData(
      Map<String, dynamic> parameters) async {
    JsonResult<GoodDetailModel> jsonResult = JsonResult<GoodDetailModel>();
    try {
      var response = await HttpUtil.instance
          .get(AppUrls.GOODS_DETAILS_URL, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        GoodDetailModel goodModel =
            GoodDetailModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = goodModel;
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

  ///商品搜素
  Future<JsonResult<SearchGoodsModel>> searchGoods(
      Map<String, dynamic> parameters) async {
    JsonResult<SearchGoodsModel> jsonResult = JsonResult<SearchGoodsModel>();
    try {
      var response = await HttpUtil.instance
          .get(AppUrls.GOODS_LIST_URL, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        SearchGoodsModel model =
        SearchGoodsModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = model;
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
}
