import 'package:flutter_shop/base/json_result.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/app_urls.dart';
import 'package:flutter_shop/model/category_goods_model.dart';
import 'package:flutter_shop/utils/http_util.dart';

class GoodsRepository{

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

}