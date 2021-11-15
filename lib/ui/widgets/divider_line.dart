import 'package:flutter/material.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';

class DividerLineView extends StatelessWidget {
  final double height;

  const DividerLineView({Key? key, this.height = AppDimens.DIMENS_1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.COLOR_EAEAEA,
      indent: 0,
      endIndent: 0,
      // ignore: unnecessary_null_comparison
      height: height,
      thickness: height,
    );
  }
}
