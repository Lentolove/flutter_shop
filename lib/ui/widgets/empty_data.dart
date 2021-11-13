import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_images.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';

///空数据时展示的界面
class EmptyDataView extends StatelessWidget {
  const EmptyDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AppImages.NO_DATA,
              height: ScreenUtil().setWidth(AppDimens.DIMENS_200),
              width: ScreenUtil().setWidth(AppDimens.DIMENS_200),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(AppDimens.DIMENS_20)),
            ),
            Text(AppStrings.PAGE_EMPTY, style: FMTextStyle.color_ff5722_size_42)
          ],
        ),
      ),
    );
  }
}
