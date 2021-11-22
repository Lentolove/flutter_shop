import 'package:flutter/material.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/ui/page/tabhome/tab_home_banner.dart';
import 'package:flutter_shop/ui/page/tabhome/tab_home_brand.dart';
import 'package:flutter_shop/ui/page/tabhome/tab_home_coupon.dart';
import 'package:flutter_shop/ui/page/tabhome/tab_home_goods_category.dart';
import 'package:flutter_shop/ui/page/tabhome/tab_home_group.dart';
import 'package:flutter_shop/ui/page/tabhome/tab_home_topic.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/view_model/tab_home_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';

import 'tab_home_goods.dart';

/// home 首页
class TabHomePage extends StatefulWidget {
  const TabHomePage({Key? key}) : super(key: key);

  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage>
    with SingleTickerProviderStateMixin {
  final TabHomeViewModel _model = TabHomeViewModel();

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    print("TabHomePage  initState");
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  ///body内容区视图
  _body(BuildContext context) {
    return ChangeNotifierProvider<TabHomeViewModel>(
      create: (context) => _model,
      child: Consumer<TabHomeViewModel>(builder: (context, model, child) {
        _refreshController.refreshCompleted();
        return RefreshConfiguration(
            child: SmartRefresher(
          header: const WaterDropMaterialHeader(
            backgroundColor: AppColors.COLOR_FF5722,
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: _initView(model),
        ));
      }),
    );
  }

  ///创建body数据,根据页面状态展示不通的内容
  Widget _initView(TabHomeViewModel model) {
    if (model.pageState == PageState.hasData) {
      return _dataView(model);
    } else {
      //无数据
      return PageStatusWidget.stateWidgetWithCallBack(model, () {
        _onRefresh();
      });
    }
  }

  ///有数据时候展示数据区域
  Widget _dataView(TabHomeViewModel model) {
    //做一下空数据过滤
    List<Widget> list = [];

    //顶部 banner 数据
    if (model.homeModel!.banner != null &&
        model.homeModel!.banner!.isNotEmpty) {
      list.add(TabHomeBanner(bannerData: model.homeModel!.banner!));
    }

    //商品分类，居家，餐厨，饮食等等。
    if (model.homeModel!.channel != null &&
        model.homeModel!.channel!.isNotEmpty) {
      list.add(TabHomeGoodsCategory(homeChannel: model.homeModel!.channel!));
    }

    //优惠券专区
    if (model.homeModel!.couponList != null &&
        model.homeModel!.couponList!.isNotEmpty) {
      list.add(TabHomeCoupon(homeCouponList: model.homeModel!.couponList!));
    }

    //团购专区
    if (model.homeModel!.grouponList != null &&
        model.homeModel!.grouponList!.isNotEmpty) {
      list.add(TabHomeGroupBuy(groupBuyList: model.homeModel!.grouponList!));
    }

    //品牌专享
    if(model.homeModel!.brandList!.isNotEmpty){
      list.add(TabHomeBrand(brandList: model.homeModel!.brandList!, title: AppStrings.MANUFACTURING));
    }

    //新品
    if(model.homeModel!.newGoodsList!.isNotEmpty){
      list.add(TabHomeGoods(goodList :model.homeModel!.newGoodsList!,title: AppStrings.NEW_PRODUCTS));
    }

    //热销产品
    if(model.homeModel!.hotGoodsList!.isNotEmpty){
      list.add(TabHomeGoods(goodList :model.homeModel!.hotGoodsList!,title: AppStrings.HOT_SALE));
    }

    //专题精选
    if(model.homeModel!.topicList!.isNotEmpty){
      list.add(TabHomeTopic(title: AppStrings.SPECIAL, topicList: model.homeModel!.topicList!));
    }

    //分类产品
    if (model.homeModel!.floorGoodsList!.isNotEmpty) {
      List<FloorGoodsList> floorGoodsList = model.homeModel!.floorGoodsList!;
      for (var item in floorGoodsList) {
        list.add(TabHomeGoods(goodList: item.goodsList!, title: item.name!));
      }
    }

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(), //防止滚动偏移超出内容的边界
      child: Column(
        //展示首页视图数据
        children: list,
      ),
    );
  }

  ///创建 appBar
  _appBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            //todo 跳转到搜搜界面
            NavigatorUtil.goSearchGoods(context);
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ],
      title: const Text(AppStrings.APP_NAME),
      centerTitle: true,
    );
  }

  ///获取首页数据
  _onRefresh() {
    _model.loadTabHomeData();
  }
}
