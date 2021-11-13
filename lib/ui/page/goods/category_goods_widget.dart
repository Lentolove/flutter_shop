import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/ui/widgets/good_widget.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/utils/refresh_state_util.dart';
import 'package:flutter_shop/view_model/category_goods_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///商品列表，两列排列
class CategoryGoodsWidget extends StatefulWidget {
  final int categoryId;

  const CategoryGoodsWidget({Key? key, required this.categoryId})
      : super(key: key);

  @override
  _CategoryGoodsWidgetState createState() => _CategoryGoodsWidgetState();
}

class _CategoryGoodsWidgetState extends State<CategoryGoodsWidget> {
  late int _categoryId;

  final CategoryGoodsViewModel _model = CategoryGoodsViewModel();

  int _pageIndex = 1;

  final int _pageSize = 6;

  double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
  double dimens10 = ScreenUtil().setWidth(AppDimens.DIMENS_10);

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _categoryId = widget.categoryId;
    _model.queryCategoryList(_categoryId, _pageIndex, _pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(dimens30),
      child: ChangeNotifierProvider<CategoryGoodsViewModel>(
        create: (_) => _model,
        child: Consumer<CategoryGoodsViewModel>(
          builder: (context, model, child) {
            _pageIndex = model.canLoadMore ? ++_pageIndex : _pageIndex;
            RefreshStateUtil.getInstance()
                .stopRefreshOrLoadMore(_refreshController);
            return _showBodyView(model);
          },
        ),
      ),
    );
  }

  _showBodyView(CategoryGoodsViewModel model) {
    if (model.pageState == PageState.hasData) {
      return _contentView(model);
    } else {
      return PageStatusWidget.stateWidgetWithCallBack(model, _onRefresh);
    }
  }

  _contentView(CategoryGoodsViewModel model) {
    return Container(
        child: SmartRefresher(
      enablePullDown: true,
      enablePullUp: _model.canLoadMore,
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      header: const WaterDropMaterialHeader(
        backgroundColor: AppColors.COLOR_FF5722,
      ),
      controller: _refreshController,
      child: GridView.builder(
          itemCount: _model.goodList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: dimens10,
              crossAxisSpacing: dimens10,
              childAspectRatio: 0.8),
          itemBuilder: (BuildContext context, int index) {
            return GoodWidget(
                good: model.goodList[index],
                itemClick: (value) {
                  //todo 跳转到详情界面
                });
          }),
    ));
  }

  ///下拉刷新
  void _onRefresh() {
    _pageIndex = 1;
    _model.queryCategoryList(_categoryId, _pageIndex, _pageSize);
  }

  ///加载更多
  void _onLoadMore() {
    _model.queryCategoryList(_categoryId, _pageIndex, _pageSize);
  }
}
