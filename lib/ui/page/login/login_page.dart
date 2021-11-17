import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/ui/widgets/loading_dialog.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/toast_util.dart';
import 'package:flutter_shop/view_model/login_view_model.dart';
import 'package:flutter_shop/view_model/user_view_model.dart';
import 'package:provider/src/provider.dart';

///登录界面
class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  final TextEditingController _accountController = TextEditingController();

  final TextEditingController _passWordController = TextEditingController();

  late LoginViewModel _model;

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _model = LoginViewModel(context.read<UserViewModel>());
    return Scaffold(
      backgroundColor: AppColors.COLOR_FFFFFF,
      appBar: AppBar(
        title: const Text(AppStrings.LOGIN),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(AppDimens.DIMENS_60),
                right: ScreenUtil().setWidth(AppDimens.DIMENS_60),
                top: ScreenUtil().setWidth(AppDimens.DIMENS_160)),
            child: Form(
              key: _loginKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.LOGIN_WELCOME,
                    style: FMTextStyle.color_333333_size_60,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(AppDimens.DIMENS_20))),
                  Text(
                    AppStrings.LOGIN_APP_INTRODUCE,
                    style: FMTextStyle.color_999999_size_36,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(AppDimens.DIMENS_100))),
                  /*用户名*/
                  TextFormField(
                    maxLines: 1,
                    maxLength: 11,
                    keyboardType: TextInputType.text,
                    validator: (v) {
                      return _validatorPhoneNum(v);
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: AppColors.COLOR_FF5722,
                        size: ScreenUtil().setWidth(AppDimens.DIMENS_80),
                      ),
                      hintText: AppStrings.USERNAME_HINT,
                      hintStyle: FMTextStyle.color_999999_size_36,
                      labelStyle: FMTextStyle.color_333333_size_42,
                      labelText: AppStrings.USERNAME,
                    ),
                    controller: _accountController,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(AppDimens.DIMENS_20))),
                  TextFormField(
                    maxLines: 1,
                    maxLength: 12,
                    obscureText: true,
                    validator: (v) {
                      return _validatorPassword(v);
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: AppColors.COLOR_FF5722,
                        size: ScreenUtil().setWidth(AppDimens.DIMENS_80),
                      ),
                      hintText: AppStrings.PASSWORD_HINT,
                      hintStyle: FMTextStyle.color_999999_size_36,
                      labelStyle: FMTextStyle.color_333333_size_42,
                      labelText: AppStrings.PASSWORD,
                    ),
                    controller: _passWordController,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(AppDimens.DIMENS_80))),
                  SizedBox(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
                      child: RaisedButton(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppDimens.DIMENS_30))),
                        color: AppColors.COLOR_FF5722,
                        onPressed: () {
                          //todo 跳转到登录界面
                          _login(context);
                        },
                        child: Text(AppStrings.LOGIN,
                            style: FMTextStyle.color_ffffff_size_42),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(AppDimens.DIMENS_42))),
                  Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
                      child: InkWell(
                        onTap: () {
                          _gotoRegister(context);
                        },
                        child: Text(
                          AppStrings.IMMEDIATELY_REGISTER,
                          style: FMTextStyle.color_333333_size_42,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //todo 跳转到登录界面
  _gotoRegister(BuildContext context) {
    NavigatorUtil.goRegister(context);
  }

  ///执行登录逻辑
  void _login(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_loginKey.currentState!.validate()) {
      _showLoginDialog(context);
      _model.login(_accountController.text, _passWordController.text).then(
          (response) {
        Navigator.pop(context);
        if (!response) {
          Navigator.pop(context);
          ToastUtil.showToast(_model.errorMessage);
        } else {
          //更新登录的状态
          context.watch<UserViewModel>().refreshData();
          Navigator.pop(context);
        }
      }, onError: (error) {
        ToastUtil.showToast(_model.errorMessage);
      });
    }
  }

  ///显示弹窗
  _showLoginDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoadingDialog(
            title: AppStrings.LOGINING,
            textColor: AppColors.COLOR_999999,
            titleSize: AppDimens.DIMENS_42,
            indicatorRadius: AppDimens.DIMENS_60,
          );
        });
  }

  ///验证用户名
  String? _validatorPhoneNum(String? value) {
    if (value == null || value.trim().toString().isEmpty ) {
      return AppStrings.ACCOUNT_RULE;
    }
    return null;
  }

  ///验证密码是否满足条件
  String? _validatorPassword(String? value) {
    if (value == null || value.trim().isEmpty || value.trim().length < 6) {
      return AppStrings.PASSWORD_RULE;
    }
    return null;
  }
}
