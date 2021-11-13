import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_images.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';

///网络异常展示的控件
class NetWorkErrorView extends StatelessWidget {
  final VoidCallback callback;

  const NetWorkErrorView({Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                AppImages.NETWORK_ERROR,
                height: ScreenUtil().setWidth(AppDimens.DIMENS_200),
                width: ScreenUtil().setWidth(AppDimens.DIMENS_200),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(AppDimens.DIMENS_20)),
                  child: Text(
                    AppStrings.SERVER_EXCEPTION,
                    style: FMTextStyle.color_ff5722_size_42,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
