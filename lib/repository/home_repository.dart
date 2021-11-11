import 'package:flutter_shop/base/json_result.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/app_urls.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/utils/http_util.dart';

///首页数据接口
class HomeRepository {
  Future<JsonResult<HomeModel>> queryHomeData() async {
    JsonResult<HomeModel> jsonResult = JsonResult<HomeModel>();
    try {
      var response = await HttpUtil.instance.get(AppUrls.HOME_URL);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        HomeModel homeEntity = HomeModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = homeEntity;
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
