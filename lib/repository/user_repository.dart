
import 'package:flutter_shop/base/json_result.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/app_urls.dart';
import 'package:flutter_shop/model/user_model.dart';
import 'package:flutter_shop/utils/http_util.dart';

///用户信息状态
class UserRepository{

  ///{
  //     "errno": 0,
  //     "data": {
  //         "userInfo": {
  //             "nickName": "tian123",
  //             "avatarUrl": "https://yanxuan.nosdn.127.net/80841d741d7fa3073e0ae27bf487339f.jpg?imageView&quality=90&thumbnail=64x64"
  //         },
  //         "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0aGlzIGlzIGxpdGVtYWxsIHRva2VuIiwiYXVkIjoiTUlOSUFQUCIsImlzcyI6IkxJVEVNQUxMIiwiZXhwIjoxNjM3MDUwNjgwLCJ1c2VySWQiOjYsImlhdCI6MTYzNzA0MzQ4MH0.f20kWHJuqFnq-YKZ3FK37kyy9LGPNSqM1LvzMPUligk"
  //     },
  //     "errmsg": "成功"
  // }
  ///注册接口
  Future<JsonResult<dynamic>> register(Map<String, dynamic> parameters) async {
    JsonResult<dynamic> jsonResult = JsonResult<dynamic>();
    try {
      var response = await HttpUtil.instance.post(AppUrls.REGISTER, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0) {
        jsonResult.isSuccess = true;
        jsonResult.data = AppStrings.SUCCESS;
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



  ///登录接口
  Future<JsonResult<UserModel>> login(Map<String, dynamic> parameters) async {
    JsonResult<UserModel> jsonResult = JsonResult<UserModel>();
    try {
      var response = await HttpUtil.instance.post(
          AppUrls.LOGIN, parameters: parameters);
      if (response[AppStrings.ERR_NO] == 0 &&
          response[AppStrings.DATA] != null) {
        UserModel userEntity = UserModel.fromJson(response[AppStrings.DATA]);
        jsonResult.isSuccess = true;
        jsonResult.data = userEntity;
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