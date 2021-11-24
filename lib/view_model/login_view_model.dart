import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/model/user_model.dart';
import 'package:flutter_shop/repository/user_repository.dart';
import 'package:flutter_shop/utils/toast_util.dart';
import 'package:flutter_shop/view_model/user_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseViewModel {
  final UserRepository _repository = UserRepository();

  UserModel? _userModel;

  ///全文通用的一个 UserViewModel
  UserViewModel userViewModel;

  LoginViewModel(this.userViewModel);

  Future<bool> login(String account, String passWord) async {
    bool result = false;
    var parameters = {
      AppParameters.USER_NAME: account,
      AppParameters.PASS_WORD: passWord
    };
    await _repository.login(parameters).then((response) {
      if (response.isSuccess) {
        _userModel = response.data;
        _saveUserInfo(account, passWord);
        userViewModel.setUserInformation(
            _userModel!.userInfo!.avatarUrl!, _userModel!.userInfo!.nickName!);
        result = true;
        notifyListeners();
      } else {
        result = false;
        ToastUtil.showToast(response.message);
      }
    });
    return result;
  }

  ///存储用户状态信息
  _saveUserInfo(String account, String password) async {
    if (_userModel == null) return;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences
        .setString(AppStrings.TOKEN, _userModel!.token!)
        .then((value) => print(value));
    await sharedPreferences.setString(
        AppStrings.HEAD_URL, _userModel!.userInfo!.avatarUrl!);
    await sharedPreferences.setString(
        AppStrings.NICK_NAME, _userModel!.userInfo!.nickName!);
    await sharedPreferences.setString("user_account", account);
    await sharedPreferences.setString("user_password", password);
    sharedPreferences.commit();
  }
}
