import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/text_style.dart';

///自定义一个View，最左边为一个图标，然后是文字，最右边是一个箭头
class IconTextArrowView extends StatelessWidget {
  final String iconUrl;
  final String title;
  final VoidCallback callback;

  double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
  double dimens60 = ScreenUtil().setWidth(AppDimens.DIMENS_60);

  IconTextArrowView(
      {Key? key,
      required this.iconUrl,
      required this.title,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
      width: double.infinity,
      child: InkWell(
        onTap: callback,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: dimens30),
              child: Image.asset(
                iconUrl,
                width: dimens60,
                height: dimens60,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: dimens30),
              child: Text(title, style: FMTextStyle.color_333333_size_42),
            ),
            Expanded(
              //占满剩余空间
              child: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: dimens30),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.COLOR_999999,
                  size: dimens30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
