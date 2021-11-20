import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_images.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/coupon_model.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/utils/refresh_state_util.dart';
import 'package:flutter_shop/view_model/coupon_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//优惠券列表界面
class CouponPage extends StatefulWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {

  final CouponViewModel _couponViewModel = CouponViewModel();
  final RefreshController _refreshController = RefreshController();

  int _pageIndex = 1;
  int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _couponViewModel.queryCoupon(_pageIndex, _pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.MINE_COUPON),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (_) => _couponViewModel,
        child: Consumer<CouponViewModel>(builder: (context, model, child) {
          _pageIndex = model.canLoadMore ? ++_pageIndex : _pageIndex;
          RefreshStateUtil.getInstance()
              .stopRefreshOrLoadMore(_refreshController);
          return _initView(model);
        }),
      ),
    );
  }

  Widget _initView(CouponViewModel model) {
    if (model.pageState == PageState.hasData) {
      return _contentView(model);
    }
    return  PageStatusWidget.stateWidgetWithCallBack(
        model, _onRefresh);
  }

  //body视图
  _contentView(CouponViewModel model){
   return SmartRefresher(
       enablePullDown: true,
       enablePullUp: model.canLoadMore,
       header: const WaterDropMaterialHeader(
         backgroundColor: AppColors.COLOR_FF5722,
       ),
       controller: _refreshController,
       onLoading: () => _onLoadMore(),
       onRefresh: () => _onRefresh(),
       child: ListView.builder(
           itemCount: model.couponList.length,
           itemBuilder: (BuildContext context, int index) {
             return _couponItemWidget(model.couponList[index]);
           }));
  }

  double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);

  //优惠券视图
  _couponItemWidget(CouponItem item){
    return Container(
      margin: EdgeInsets.only(left: dimens30, right:dimens30, top: ScreenUtil().setHeight(AppDimens.DIMENS_20)),
      height: ScreenUtil().setHeight(AppDimens.DIMENS_270),
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.BG_COUPON), fit: BoxFit.fill)),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(AppDimens.DIMENS_240),
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(AppDimens.DIMENS_60),
                right: ScreenUtil().setWidth(AppDimens.DIMENS_60)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppStrings.DOLLAR,
                  style: FMTextStyle.color_ff5722_size_42,
                ),
                Text(
                  "${item.discount}",
                  style: FMTextStyle.color_ff5722_size_80,
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${item.name} + ${item.desc}",
                      style: FMTextStyle.color_333333_size_42,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(AppDimens.DIMENS_20))),
                    Text(
                      AppStrings.FULL + "${item.min}" + AppStrings.USE,
                      style: FMTextStyle.color_333333_size_42,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(AppDimens.DIMENS_20))),
                    Text(
                      _transformDate(item.startTime!) + "~" + _transformDate(item.endTime!),
                      style: FMTextStyle.color_333333_size_42,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  //格式化事件
  _transformDate(String time) {
    var data = DateTime.parse(time);
    return DateUtil.formatDate(data, format: DateFormats.y_mo_d);
  }

  //刷新
  void _onRefresh() {
    _pageIndex = 1;
    _couponViewModel.queryCoupon(_pageIndex, _pageSize);
  }

  //加载更多
  void _onLoadMore() {
    _couponViewModel.queryCoupon(_pageIndex, _pageSize);
  }
}
