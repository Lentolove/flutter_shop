import 'package:flutter/material.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/ui/page/tabhome/tab_home_banner.dart';
import 'package:flutter_shop/view_model/tab_home_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';

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
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(), //防止滚动偏移超出内容的边界
      child: Column(
        //展示首页视图数据
        children: [
          TabHomeBanner(bannerData: model.homeModel!.banner),
        ],
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
