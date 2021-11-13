import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';

///正在加载界面
class LoadingDialog extends StatelessWidget {
  final String title;
  final double titleSize; //文本字体大小
  final Color textColor; //文本颜色
  final double indicatorRadius; // 圆形进度的半径

  const LoadingDialog(
      {Key? key,
      required this.title,
      this.titleSize = AppDimens.DIMENS_42,
      this.textColor = AppColors.COLOR_999999,
      this.indicatorRadius = AppDimens.DIMENS_60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: () {
          //todo
        },
        child: SizedBox(
          height: ScreenUtil().setHeight((AppDimens.DIMENS_20 +
              (2 * indicatorRadius).toDouble() +
              titleSize +
              AppDimens.DIMENS_60)),
          width: ScreenUtil().setHeight(AppDimens.DIMENS_400),
          child: Container(
            decoration: const ShapeDecoration(
              color: AppColors.COLOR_FFFFFF,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimens.DIMENS_10),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(
                  animating: true,
                  radius: ScreenUtil().setHeight(indicatorRadius),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      ScreenUtil().setHeight(AppDimens.DIMENS_20)),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(titleSize),
                        color: textColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
