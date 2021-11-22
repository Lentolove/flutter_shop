import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/text_style.dart';

///购物车界面，计数自定义View,左右两个加减号，中间一个数字计数
class CartNumberView extends StatefulWidget {
  final ValueChanged<int> callback;

  int number = 0;

  CartNumberView({Key? key, required this.callback, this.number = 0})
      : super(key: key);

  @override
  _CartNumberViewState createState() => _CartNumberViewState();
}

class _CartNumberViewState extends State<CartNumberView> {
  var count = 1;

  @override
  void initState() {
    super.initState();
    count = widget.number;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().setWidth(AppDimens.DIMENS_240),
      height: ScreenUtil().setWidth(AppDimens.DIMENS_80),
      child: Row(
        children: [
          InkWell(
            onTap: () => _reduce(),
            child: Container(
              width: ScreenUtil().setWidth(AppDimens.DIMENS_80),
              height: double.infinity,
              alignment: Alignment.center,
              decoration: const ShapeDecoration(
                  shape: Border(
                      left:
                          BorderSide(color: AppColors.COLOR_F0F0F0, width: 1.0),
                      top:
                          BorderSide(color: AppColors.COLOR_F0F0F0, width: 1.0),
                      right:
                          BorderSide(color: AppColors.COLOR_F0F0F0, width: 1.0),
                      bottom: BorderSide(
                          color: AppColors.COLOR_F0F0F0, width: 1.0))),
              child: Text("-", style: FMTextStyle.color_333333_size_42),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: ScreenUtil().setWidth(AppDimens.DIMENS_80),
            decoration: const ShapeDecoration(
                shape: Border(
                    top: BorderSide(color: AppColors.COLOR_F0F0F0, width: 1.0),
                    bottom:
                        BorderSide(color: AppColors.COLOR_F0F0F0, width: 1.0))),
            child: Text('$count',
                style: FMTextStyle.color_333333_size_42),
          ),
          InkWell(
              onTap: () => _add(),
              child: Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(AppDimens.DIMENS_80),
                height: double.infinity,
                decoration: const ShapeDecoration(
                    color: AppColors.COLOR_FF5722,
                    shape: Border(
                        left: BorderSide(
                            color: AppColors.COLOR_FF5722, width: 1.0),
                        top: BorderSide(
                            color: AppColors.COLOR_FF5722, width: 1.0),
                        right: BorderSide(
                            color: AppColors.COLOR_FF5722, width: 1.0),
                        bottom: BorderSide(
                            color: AppColors.COLOR_FF5722, width: 1.0))),
                child: Text("+", style: FMTextStyle.color_ffffff_size_42),
              )),
        ],
      ),
    );
  }

  ///减少
  _reduce() {
    if (count > 1) {
      setState(() {
        count -= 1;
      });
      widget.callback(count);
    }
  }

  ///增加
  _add() {
    setState(() {
      count += 1;
    });
    widget.callback(count);
  }
}
