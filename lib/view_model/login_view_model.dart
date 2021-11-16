import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/repository/user_repository.dart';
import 'package:flutter_shop/utils/toast_util.dart';


class LoginViewModel extends BaseViewModel{

  final UserRepository _repository = UserRepository();


  Future<bool> login(String account, String passWord) async {
    bool result = false;
    var parameters = {
      AppParameters.USER_NAME: account,
      AppParameters.PASS_WORD: passWord
    };
    await _repository.login(parameters).then((response) {
      if (response.isSuccess) {
        // _userEntity = response.data;
        // _saveUserInfo();
        // _userViewModel.setPersonInformation(
        //     _userEntity.userInfo.avatarUrl, _userEntity.userInfo.nickName);
        ToastUtil.showToast(response.message);
        print("登录成功");
        notifyListeners();
        result = true;
      } else {
        result = false;
        ToastUtil.showToast(response.message);
      }
    });
    return result;
  }

}