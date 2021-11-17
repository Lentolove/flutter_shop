import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_images.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/shared_preferences_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///app首次进入引导界面
class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  var guides = [AppImages.GUIDE_1, AppImages.GUIDE_2, AppImages.GUIDE_3];

  var _showButton = false;

  @override
  Widget build(BuildContext context) {
    //更新状态，只有首次打开才显示
    SharedPreferencesUtil.instance.setBool(AppStrings.IS_FIRST, false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _guideWidget(),
          //跳过按钮
          Positioned(
              right: ScreenUtil().setWidth(AppDimens.DIMENS_30),
              bottom: ScreenUtil().setHeight(AppDimens.DIMENS_30),
              child: Offstage(
                offstage: !_showButton,
                child: Center(
                    child: FlatButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppDimens.DIMENS_30))),
                  color: AppColors.COLOR_FF5722,
                  textColor: AppColors.COLOR_FFFFFF,
                  onPressed: () {
                    NavigatorUtil.goMallMainPage(context);
                  },
                  child: const Text(AppStrings.OPEN_DOOR,
                      style: TextStyle(fontSize: AppDimens.BIG_TEXT_SIZE)),
                )),
              )),
        ],
      ),
    );
  }

  _guideWidget() {
    return Swiper(
      itemCount: guides.length,
      //item数量
      scrollDirection: Axis.horizontal,
      //滚动方向 设置为Axis.vertical如果需要垂直滚动
      itemBuilder: (BuildContext context, int index) {
        return Image.asset(
          guides[index],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        );
      },
      autoplay: false,
      loop: false,
      pagination: const SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            activeColor: AppColors.COLOR_FF5722, //选中的颜色
            color: AppColors.COLOR_999999, //非选中的颜色
          )),
      onIndexChanged: ((value) {
        //图片数组下标变化监听
        if (value == guides.length - 1) {
          setState(() {
            _showButton = true;
          });
        } else if (_showButton && value != guides.length - 1) {
          //减少非必要的 setState 只有当滑动到最后一张图片然后向做滑动的时候触发
          setState(() {
            _showButton = false;
          });
        }
      }),
    );
  }
}
