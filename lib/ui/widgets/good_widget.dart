import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/home_model.dart';

import 'cached_image.dart';

///定义点击回调
typedef ItemClick = Function(int value);

///通用的商品信息 Widget
class GoodWidget extends StatelessWidget {
  final GoodsModel good;

  final ItemClick itemClick;

  const GoodWidget({Key? key, required this.good, required this.itemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dimens400 = ScreenUtil().setHeight(AppDimens.DIMENS_400);
    double dimens20 = ScreenUtil().setHeight(AppDimens.DIMENS_20);
    return GestureDetector(
      onTap: () {
        itemClick(good.id!);
      },
      child: Card(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              CachedImageView(
                dimens400,
                dimens400,
                good.picUrl!,
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(dimens20, dimens20, dimens20, dimens20),
                child: Text(good.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FMTextStyle.color_333333_size_42),
              ),
              Text("${AppStrings.DOLLAR}${good.retailPrice}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FMTextStyle.color_ff5722_size_42),
            ],
          ),
        ),
      ),
    );
  }
}
