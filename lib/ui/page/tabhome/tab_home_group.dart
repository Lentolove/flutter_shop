import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/ui/widgets/cached_image.dart';

///团购专区
class TabHomeGroupBuy extends StatelessWidget {
  final List<HomeModelGrouponlist> groupBuyList;

  const TabHomeGroupBuy({Key? key, required this.groupBuyList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
    return Column(children: [
      Container(
        margin: EdgeInsets.only(top: dimens30, bottom: 30),
        alignment: Alignment.center,
        child: Text(AppStrings.GROUP_BUG,
            style: FMTextStyle.color_333333_size_42_bold),
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: groupBuyList.length,
        itemBuilder: (BuildContext context, int index) {
          return _getGroupBuyItem(context, groupBuyList[index]);
        },
      ),
    ]);
  }

  _getGroupBuyItem(BuildContext context, HomeModelGrouponlist group) {
    double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
    double dimens180 = ScreenUtil().setWidth(AppDimens.DIMENS_180);
    return Container(
      margin: EdgeInsets.only(left: dimens30, right: 30),
      child: Card(
        child: Container(
          padding: EdgeInsets.only(top: dimens30, bottom: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedImageView(dimens180, dimens180, group.picUrl!),
              Container(
                padding: EdgeInsets.only(left: dimens30),
                width: ScreenUtil().setWidth(AppDimens.DIMENS_500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: dimens30),
                      child: Text(group.name!,
                          style: FMTextStyle.color_333333_size_42),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: dimens30),
                      child: Text(
                        group.brief ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FMTextStyle.color_999999_size_42,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: dimens30),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "${AppStrings.ORIGINAL_PRICE}${group.retailPrice}",
                            style: TextStyle(
                                fontSize:
                                    ScreenUtil().setSp(AppDimens.DIMENS_42),
                                color: AppColors.COLOR_999999,
                                decoration: TextDecoration.lineThrough,
                                decorationStyle: TextDecorationStyle.dashed),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: dimens30),
                            child: Text(
                                "${AppStrings.CURRENT_PRICE}${group.retailPrice}",
                                style: FMTextStyle.color_ff5722_size_42),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
