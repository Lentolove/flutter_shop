import 'package:flutter/material.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/view_model/category_goods_view_model.dart';
import 'package:provider/provider.dart';

import 'category_goods_widget.dart';

///首页商品分类详情列表页，一级菜单：居家 -》二级菜单 =》三级的body
class HomeCategoryGoodsPage extends StatefulWidget {
  final String title;
  final int id;

  const HomeCategoryGoodsPage({Key? key, required this.title, required this.id})
      : super(key: key);

  @override
  _HomeCategoryGoodsPageState createState() => _HomeCategoryGoodsPageState();
}

class _HomeCategoryGoodsPageState extends State<HomeCategoryGoodsPage>
    with TickerProviderStateMixin {
  final CategoryGoodsViewModel _model = CategoryGoodsViewModel();

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _model.queryCategoryName(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _model,
      child: Consumer<CategoryGoodsViewModel>(builder: (context, model, child) {
        _controller = TabController(
            length: model.categoryTitleModel == null
                ? 0
                : model.categoryTitleModel!.brotherCategory!.length,
            vsync: this);
        return Scaffold(
          appBar: AppBar(
              title: Text(widget.title),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Material(
                  color: AppColors.COLOR_FFFFFF,
                  child: TabBar(
                    isScrollable: true,
                    controller: _controller,
                    indicatorColor: AppColors.COLOR_FF5722,
                    labelColor: AppColors.COLOR_FF5722,
                    unselectedLabelColor: AppColors.COLOR_999999,
                    tabs: _tabBars(model.categoryTitleModel == null
                        ? []
                        : model.categoryTitleModel!.brotherCategory!),
                  ),
                ),
              )),
          body: TabBarView(
            controller: _controller,
            children: _tabBarViews(model.categoryTitleModel == null
                ? []
                : model.categoryTitleModel!.brotherCategory!),
          ),
        );
      }),
    );
  }

  //构建顶部tabBar
  _tabBars(List<CategoryModel> titles) {
    List<Widget> titleBar = [];
    for (var item in titles) {
      titleBar.add(Tab(text: item.name!));
    }
    return titleBar;
  }

  //商品列表展示区
  _tabBarViews(List<CategoryModel> list) {
    List<Widget> contentWidgets = [];
    for (var item in list) {
      contentWidgets.add(CategoryGoodsWidget(categoryId: item.id!));
    }
    return contentWidgets;
  }
}
