import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/home_model.dart';

/// 首页的优惠券
class TabHomeCoupon extends StatelessWidget {
  final List<CouponList> homeCouponList;

  const TabHomeCoupon({Key? key,required this.homeCouponList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dimens_30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
    double dimens_10 = ScreenUtil().setWidth(AppDimens.DIMENS_10);
    return homeCouponList.isEmpty
        ? Container()
        : Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: dimens_30,bottom: dimens_30),
                alignment: Alignment.center,
                //团购专区
                child: Text(AppStrings.COUPON_AREA,
                    style: FMTextStyle.color_333333_size_42_bold),
              ),
              ListView.builder(
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: homeCouponList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _getCouponView(context, homeCouponList[index]);
                },
              ),
            ],
          );
  }

  //优惠券的样式
  _getCouponView(BuildContext context, CouponList coupon) {
    double dimens_30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
    double dimens_20 = ScreenUtil().setWidth(AppDimens.DIMENS_20);
    return InkWell(
      onTap: () {
        //todo 领取优惠券
      },
      child: Card(
        margin: EdgeInsets.all(dimens_30),
        child: Container(
          margin: EdgeInsets.only(top: dimens_20, bottom: dimens_20),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: dimens_20),
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(AppDimens.DIMENS_210),
                child: Text("${coupon.discount}${AppStrings.MONEY_UNIT}",
                    style: FMTextStyle.color_ff5722_size_60),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: dimens_20)),
                    Text(coupon.name!, style: FMTextStyle.color_333333_size_42),
                    Padding(padding: EdgeInsets.only(top: dimens_20)),
                    Text("${AppStrings.FULL}${coupon.min}${AppStrings.USE}",
                        style: FMTextStyle.color_999999_size_42),
                    Padding(padding: EdgeInsets.only(top: dimens_20)),
                    Text(
                        "${AppStrings.VALIDITY}${coupon.days}${AppStrings.DAY}",
                        style: FMTextStyle.color_999999_size_42),
                    Padding(padding: EdgeInsets.only(top: dimens_20)),
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
