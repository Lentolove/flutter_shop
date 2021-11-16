import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/json_result.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/app_urls.dart';
import 'package:flutter_shop/model/user_model.dart';
import 'package:flutter_shop/repository/user_repository.dart';
import 'package:flutter_shop/utils/http_util.dart';
import 'package:flutter_shop/utils/toast_util.dart';

//注册
class RegisterViewModel extends BaseViewModel{

  final UserRepository _repository = UserRepository();

  //注册接口
  Future<bool> register(String account,String phone,String password) async{
    var parameters = {
      AppParameters.USER_NAME: account,
      AppParameters.PASS_WORD: password,
      AppParameters.MOBILE: phone,
      AppParameters.CODE: "8888"
    };
    bool result = false;
    await _repository.register(parameters).then((response) {
      if (response.isSuccess) {
        result = true;
      } else {
        ToastUtil.showToast(response.message);
        result = false;
      }
    });
    return result;
  }



}