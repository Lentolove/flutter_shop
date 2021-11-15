import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/model/good_detail_model.dart';
import 'package:flutter_shop/ui/widgets/cached_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///商品详情页界面顶部轮播图
class GoodDetailSwiper extends StatelessWidget {
  final GoodsDetailInfo info;

  const GoodDetailSwiper({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: ScreenUtil().setHeight(AppDimens.DIMENS_480),
        child: Swiper(
          itemCount: info.gallery!.length,
          scrollDirection: Axis.horizontal,
          loop: true,
          index: 0,
          autoplay: true,
          itemBuilder: (context, index) {
            return CachedImageView(
                double.infinity, double.infinity, info.gallery![index]);
          },
          duration: 1000,
          pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                  size: ScreenUtil().setWidth(AppDimens.DIMENS_18),
                  activeSize: ScreenUtil().setWidth(AppDimens.DIMENS_18),
                  color: Colors.white,
                  activeColor: AppColors.COLOR_FF5722)),
        ));
  }
}
