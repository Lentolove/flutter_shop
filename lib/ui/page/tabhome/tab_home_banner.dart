import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_images.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/ui/widgets/cached_image.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///TabHome 首页顶部的轮播图
class TabHomeBanner extends StatelessWidget {
  ///轮播图数据
  final List<HomeBanner> bannerData;

  const TabHomeBanner({Key? key, required this.bannerData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.COLOR_F0F0F0,
      height: ScreenUtil().setHeight(AppDimens.DIMENS_480),
      width: double.infinity,
      child: bannerData.isEmpty
          ? Image.asset(AppImages.DEFAULT_PICTURE)
          : Swiper(
              onTap: (index) {
                //todo
                NavigatorUtil.goWebView(
                    context, bannerData[index].name!, bannerData[index].link!);
              },
              itemCount: bannerData.length,
              scrollDirection: Axis.horizontal,
              loop: true,
              index: 0,
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return CachedImageView(
                    double.infinity, double.infinity, bannerData[index].url!);
              },
              duration: 1000,
              pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  //滑动指示器
                  builder: DotSwiperPaginationBuilder(
                      size: ScreenUtil().setWidth(AppDimens.DIMENS_18),
                      activeSize: ScreenUtil().setWidth(AppDimens.DIMENS_18),
                      color: Colors.white,
                      activeColor: AppColors.COLOR_FF5722))),
    );
  }
}
