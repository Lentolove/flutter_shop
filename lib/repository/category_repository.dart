import 'package:flutter_shop/base/json_result.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/app_urls.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/model/category_title_model.dart';
import 'package:flutter_shop/utils/http_util.dart';

///分类界面数据
class CategoryRepository {

  ///获取一级分类数据
  Future<JsonResult<CategoryList>> getCategoryData() async {
    JsonResult<CategoryList> jsonResult = JsonResult<CategoryList>();
    try {
      var responseList = [];
      var response = await HttpUtil.instance.get(AppUrls.HOME_FIRST_CATEGORY);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        responseList = response[AppStrings.DATA];
        CategoryList categoryList = CategoryList.fromJson(responseList);
        jsonResult.isSuccess = true;
        jsonResult.data = categoryList;
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

  ///获取二级分类
  Future<JsonResult<CategoryList>> getSubCategoryData(
      Map<String, dynamic> parameters) async {
    JsonResult<CategoryList> jsonResult = JsonResult<CategoryList>();
    try {
      var responseList = [];
      var response = await HttpUtil.instance
          .get(AppUrls.HOME_SECOND_CATEGORY, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        responseList = response[AppStrings.DATA];
        CategoryList categoryList = CategoryList.fromJson(responseList);
        jsonResult.isSuccess = true;
        jsonResult.data = categoryList;
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

  /// 获取商品分类标题
  Future<JsonResult<CategoryTitleModel>> getCategoryTitle(
      Map<String, dynamic> parameters) async {
    JsonResult<CategoryTitleModel> jsonResult = JsonResult<CategoryTitleModel>();
    try {
      var response = await HttpUtil.instance
          .get(AppUrls.CATEGORY_LIST, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        CategoryTitleModel categoryTitleEntity = CategoryTitleModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = categoryTitleEntity;
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
