import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/ui/widgets/loading_dialog.dart';
import 'package:flutter_shop/utils/toast_util.dart';
import 'package:flutter_shop/view_model/register_view_model.dart';

///注册界面
class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();

  //用户名
  final TextEditingController _userNameController = TextEditingController();

  //手机号
  final TextEditingController _accountController = TextEditingController();

  //密码
  final TextEditingController _passWordController = TextEditingController();

  final TextEditingController _confirmPassWordController =
      TextEditingController();

  final RegisterViewModel _model = RegisterViewModel();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dimens60 = ScreenUtil().setWidth(AppDimens.DIMENS_60);
    double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
    double dimens160 = ScreenUtil().setWidth(AppDimens.DIMENS_160);
    return Scaffold(
      backgroundColor: AppColors.COLOR_FFFFFF,
      appBar: AppBar(
        title: const Text(AppStrings.REGISTER),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: dimens30, right: dimens30, top: dimens160),
            child: Form(
                key: _registerKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.REGISTER_WELCOME,
                      style: FMTextStyle.color_333333_size_60,
                    ),
                    Padding(padding: EdgeInsets.only(top: dimens30)),
                    Text(
                      AppStrings.LOGIN_APP_INTRODUCE,
                      style: FMTextStyle.color_999999_size_36,
                    ),
                    Padding(padding: EdgeInsets.only(top: dimens30)),
                    /*用户名*/
                    TextFormField(
                      maxLines: 1,
                      maxLength: 10,
                      keyboardType: TextInputType.name,
                      validator: (v) {
                        return v!.trim().isEmpty ? "用户名不能为空" : null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: AppColors.COLOR_999999,
                          size: ScreenUtil().setWidth(AppDimens.DIMENS_80),
                        ),
                        hintText: AppStrings.USERNAME_HINT,
                        hintStyle: FMTextStyle.color_999999_size_36,
                        labelStyle: FMTextStyle.color_333333_size_42,
                        labelText: AppStrings.USERNAME,
                      ),
                      controller: _userNameController,
                    ),

                    //表单验证：https://book.flutterchina.club/chapter3/input_and_form.html#_3-5-2-%E8%A1%A8%E5%8D%95form
                    /*验证手机号*/
                    TextFormField(
                      maxLines: 1,
                      maxLength: 11,
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        return _validatorPhoneNum(v);
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone_android_sharp,
                          color: AppColors.COLOR_999999,
                          size: ScreenUtil().setWidth(AppDimens.DIMENS_80),
                        ),
                        hintText: AppStrings.PHONE_HINT,
                        hintStyle: FMTextStyle.color_999999_size_36,
                        labelStyle: FMTextStyle.color_333333_size_42,
                        labelText: AppStrings.PHONE,
                      ),
                      controller: _accountController,
                    ),
                    /*验证密码*/
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
                          color: AppColors.COLOR_999999,
                          size: ScreenUtil().setWidth(AppDimens.DIMENS_80),
                        ),
                        hintText: AppStrings.PASSWORD_HINT,
                        hintStyle: FMTextStyle.color_999999_size_36,
                        labelStyle: FMTextStyle.color_333333_size_42,
                        labelText: AppStrings.PASSWORD,
                      ),
                      controller: _passWordController,
                    ),
                    Padding(padding: EdgeInsets.only(top: dimens30)),

                    /*确认密码*/
                    TextFormField(
                      maxLines: 1,
                      maxLength: 12,
                      obscureText: true,
                      validator: (v) {
                        return _confirmPassword(v);
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phonelink_lock,
                          color: AppColors.COLOR_999999,
                          size: ScreenUtil().setWidth(AppDimens.DIMENS_80),
                        ),
                        hintText: AppStrings.CONFIRM_HINT,
                        hintStyle: FMTextStyle.color_999999_size_36,
                        labelStyle: FMTextStyle.color_333333_size_42,
                        labelText: AppStrings.CONFIRM_PASSWORD,
                      ),
                      controller: _confirmPassWordController,
                    ),
                    Padding(padding: EdgeInsets.only(top: dimens30)),

                    SizedBox(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
                      child: RaisedButton(
                        color: AppColors.COLOR_FFBF86,
                        onPressed: () {
                          //todo 调用注册逻辑
                          _register(context);
                        },
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppDimens.DIMENS_30))),
                        child: Text(
                          AppStrings.IMMEDIATELY_REGISTER,
                          style: FMTextStyle.color_ffffff_size_42,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  ///验证手机号是否满足
  String? _validatorPhoneNum(String? value) {
    if (value == null ||
        value.trim().toString().isEmpty ||
        value.trim().toString().length < 11) {
      return AppStrings.PHONENUM_RULE;
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

  ///验证密码
  String? _confirmPassword(String? value) {
    if (value == null || value.trim().isEmpty || value.trim().length < 6) {
      return AppStrings.PASSWORD_RULE;
    }else if(value != _passWordController.text.trim()){
      return AppStrings.CONFIRMPASSWORD_RULE;
    }
    return null;
  }

  ///注册
  void _register(BuildContext context) {
    if (_registerKey.currentState!.validate()) {
      _showRegisterDialog(context);
      _model
          .register(_userNameController.text.trim(),
              _accountController.text.trim(), _passWordController.text.trim())
          .then((value) {
        Navigator.pop(context);
        if (value) {
          ToastUtil.showToast(AppStrings.REGISTER_SUCCESS);
          // Navigator.pop(context);
        }
      });
    }
  }

  ///显示一个等待弹窗
  _showRegisterDialog(BuildContext context) {
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
}
