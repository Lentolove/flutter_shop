import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/text_style.dart';

///左右两边文字的widget
class ItemTextView extends StatelessWidget {
  final String leftText;
  final String rightText;
  VoidCallback? callback;

  ItemTextView(
      {Key? key,
      required this.leftText,
      required this.rightText, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(callback != null){
          callback!();
        }
      },
      child: Container(
        color: AppColors.COLOR_FFFFFF,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(AppDimens.DIMENS_30),
            right: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
        height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
        child: Row(
          children: <Widget>[
            Text(
              leftText,
              style: FMTextStyle.color_333333_size_42,
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                rightText,
                style: FMTextStyle.color_999999_size_42,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
