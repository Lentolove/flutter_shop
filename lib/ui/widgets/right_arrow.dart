import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_images.dart';

class RightArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.ARROW_RIGHT,
      height: ScreenUtil().setWidth(AppDimens.DIMENS_60),
      width: ScreenUtil().setWidth(AppDimens.DIMENS_60),
    );
  }
}
