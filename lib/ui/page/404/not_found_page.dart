import 'package:flutter/material.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_images.dart';
import 'package:flutter_shop/constant/app_string.dart';

///路有插件默认未找到时候的进入的页面
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(AppStrings.APP_NAME),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Image.asset(
            AppImages.NOT_FIND_PICTURE,
            width: 200,
            height: 100,
            color: AppColors.COLOR_FF5722,
          ),
        ));
  }
}
