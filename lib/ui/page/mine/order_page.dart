import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';

import 'oder_list_page.dart';

//我的订单界面
class OrderPage extends StatefulWidget {
  final int initIndex;

  const OrderPage({Key? key, required this.initIndex}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  //顶部title导航
  final List<String> _title = [
    AppStrings.ORDER_ALL,
    AppStrings.TO_BE_PAID,
    AppStrings.TO_BE_DELIVERED,
    AppStrings.TO_BE_RECEIVED,
    AppStrings.TO_BE_EVALUATED,
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initIndex,
      length: _title.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.MINE_ORDER),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              color: AppColors.COLOR_FFFFFF,
              child: TabBar(
                tabs: _titleBars(),
                indicatorColor: AppColors.COLOR_FF5722,
                labelColor: AppColors.COLOR_FF5722,
                unselectedLabelColor: AppColors.COLOR_999999,
              ),
            ),
          ),
        ),
        body: TabBarView(children: _tabBarViews()),
      ),
    );
  }

  //标题导航栏
  _titleBars() {
    List<Widget> titles = [];
    for (var element in _title) {
      titles.add(Tab(
        child: Text(
          element,
          style: TextStyle(fontSize: ScreenUtil().setSp(AppDimens.DIMENS_36)),
        ),
      ));
    }
    return titles;
  }

  //body视图
  _tabBarViews() {
    List<Widget> tabBarViews = [];
    for (int i = 0; i < 5; i++) {
      tabBarViews.add(OrderListPage(showType: i));
    }
    return tabBarViews;
  }
}
