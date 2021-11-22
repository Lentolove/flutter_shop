import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/ui/widgets/good_widget.dart';
import 'package:flutter_shop/ui/widgets/loading_dialog.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/refresh_state_util.dart';
import 'package:flutter_shop/view_model/search_good_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///搜索界面
class SearchGoodsPage extends StatefulWidget {
  const SearchGoodsPage({Key? key}) : super(key: key);

  @override
  _SearchGoodsPageState createState() => _SearchGoodsPageState();
}

class _SearchGoodsPageState extends State<SearchGoodsPage> {
  final TextEditingController _keyController = TextEditingController();

  final SearchGoodViewModel _searchGoodViewModel = SearchGoodViewModel();

  final RefreshController _refreshController = RefreshController();

  FocusNode _focusNode = FocusNode();
  var _pageIndex = 1;
  var _pageSize = 10;
  var _sortName = AppStrings.SORT_NAME;
  var _orderType = AppStrings.DESC;

  @override
  void initState() {
    super.initState();
    _searchGoodViewModel.pageState = PageState.empty;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchGoodViewModel>(
        create: (_) => _searchGoodViewModel,
        child: Selector<SearchGoodViewModel, List<GoodsModel>>(
          builder: (context, model, child) {
            if (_searchGoodViewModel.isLoadMore) {
              _pageIndex++;
            }
            RefreshStateUtil.getInstance()
                .stopRefreshOrLoadMore(_refreshController);
            return Scaffold(
              appBar: AppBar(
                title: _searchWidget(),
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: _conditionWidget(),
                ),
              ),
              body: _contentWidget(),
            );
          },
          selector: (context, model) => model.goodList,
        ));
  }

  _conditionWidget() {
    return Container(
      color: AppColors.COLOR_FFFFFF,
      height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Selector<SearchGoodViewModel, bool>(
                builder: (context, data, child) {
              return GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.PUBLISH_TIME,
                      style: FMTextStyle.color_333333_size_42,
                    ),
                    Icon(
                      _searchGoodViewModel.publishTimeConditionArrowUp
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.COLOR_999999,
                    ),
                  ],
                ),
                onTap: () => _showPublishTimeDialog(),
              );
            }, selector: (context, model) {
              return model.publishTimeConditionArrowUp;
            }),
          ),
          Expanded(
            flex: 1,
            child: Selector<SearchGoodViewModel, bool>(
                builder: (context, data, child) {
              return GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.PRICE_CONDITION,
                      style: FMTextStyle.color_333333_size_42,
                    ),
                    Icon(
                      _searchGoodViewModel.priceConditionArrowUp
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.COLOR_999999,
                    ),
                  ],
                ),
                onTap: () => _showPriceDialog(),
              );
            }, selector: (context, model) {
              return model.priceConditionArrowUp;
            }),
          ),
        ],
      ),
    );
  }

  ///搜索框
  _searchWidget() {
    return Container(
      height: AppBar().preferredSize.height,
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(AppDimens.DIMENS_30),
          bottom: ScreenUtil().setHeight(AppDimens.DIMENS_30)),
      alignment: Alignment.center,
      color: AppColors.COLOR_FF5722,
      child: Container(
          margin: EdgeInsets.only(
              right: ScreenUtil().setWidth(AppDimens.DIMENS_100)),
          decoration: BoxDecoration(
            color: AppColors.COLOR_FFFFFF,
            border: Border.all(
                color: AppColors.COLOR_FFFFFF,
                width: ScreenUtil().setWidth(AppDimens.DIMENS_1)),
            borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(AppBar().preferredSize.height / 2)),
          ),
          child: TextField(
            onEditingComplete: _sort,
            controller: _keyController,
            textInputAction: TextInputAction.search,
            focusNode: _focusNode,
            style: FMTextStyle.color_333333_size_42,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: ScreenUtil().setWidth(AppDimens.DIMENS_80),
                color: AppColors.COLOR_FF5722,
              ),
              hintText: AppStrings.GOODS_SEARCH_HINT,
              hintStyle: FMTextStyle.color_999999_size_42,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          )),
    );
  }

  _showWidget(SearchGoodViewModel model) {
    if (model.pageState == PageState.hasData) {
      return _goodsWidget();
    }
    return PageStatusWidget.stateWidgetWithCallBack(model, _onRefresh);
  }

  //主体数据
  _contentWidget() {
    return SmartRefresher(
      enablePullUp: _searchGoodViewModel.isLoadMore,
      enablePullDown: true,
      header: const WaterDropMaterialHeader(
        backgroundColor: AppColors.COLOR_FF5722,
      ),
      controller: _refreshController,
      child: _showWidget(_searchGoodViewModel),
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
    );
  }

  //商品列表
  _goodsWidget() {
    print("_goodsWidget ${_searchGoodViewModel.goodList.length}");
    return GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemCount: _searchGoodViewModel.goodList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.9),
        itemBuilder: (BuildContext context, int index) {
          return GoodWidget(
              good: _searchGoodViewModel.goodList[index],
              itemClick: (value) {
                NavigatorUtil.goGoodsDetails(
                    context, _searchGoodViewModel.goodList[value].id!);
              });
        });
  }

  _showPublishTimeDialog() {
    _focusNode.unfocus();
    _searchGoodViewModel.setPublishTimeCondition();
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppDimens.DIMENS_20),
                topRight: Radius.circular(AppDimens.DIMENS_20))),
        builder: (BuildContext context) {
          return SizedBox(
            height: ScreenUtil().setHeight(AppDimens.DIMENS_300),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(AppDimens.DIMENS_30)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
                    child: GestureDetector(
                      onTap: () {
//                        _orderType = AppStrings.ASC;
//                        _sortName = AppStrings.PUBLISH_TIME;
//                        _onRefresh();
                        Navigator.pop(context);
                      },
                      child: Text(AppStrings.PUBLISH_TIME_ASC,
                          style: FMTextStyle.color_333333_size_42),
                    )),
                Container(
                    margin: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(AppDimens.DIMENS_30)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
                    child: GestureDetector(
                      onTap: () {
//                        _orderType = AppStrings.DESC;
//                        _sortName = AppStrings.PUBLISH_TIME;
//                        _onRefresh();
                        Navigator.pop(context);
                      },
                      child: Text(AppStrings.PUBLISH_TIME_DESC,
                          style: FMTextStyle.color_333333_size_42),
                    ))
              ],
            ),
          );
        }).whenComplete(() {
      _searchGoodViewModel.setPublishTimeCondition();
    });
  }

  ///显示按照商品价格排序的弹窗
  _showPriceDialog() {
    _focusNode.unfocus();
    _searchGoodViewModel.setPriceCondition();
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppDimens.DIMENS_20),
                topRight: Radius.circular(AppDimens.DIMENS_20))),
        builder: (BuildContext context) {
          return SizedBox(
            height: ScreenUtil().setHeight(AppDimens.DIMENS_300),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(AppDimens.DIMENS_30)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
                    child: GestureDetector(
                      onTap: () {
                        _orderType = AppStrings.ASC;
                        _sortName = AppStrings.SORT_RETAIL_PRICE;
                        _onRefresh();
                        Navigator.pop(context);
                      },
                      child: Text(AppStrings.PRICE_ASC,
                          style: FMTextStyle.color_333333_size_42),
                    )),
                Container(
                    margin: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(AppDimens.DIMENS_30)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
                    child: GestureDetector(
                      onTap: () {
                        _orderType = AppStrings.DESC;
                        _sortName = AppStrings.SORT_RETAIL_PRICE;
                        _onRefresh();
                        Navigator.pop(context);
                      },
                      child: Text(AppStrings.PRICE_DESC,
                          style: FMTextStyle.color_333333_size_42),
                    ))
              ],
            ),
          );
        }).whenComplete(() {
      _searchGoodViewModel.setPriceCondition();
    });
  }

  ///刷新
  _onRefresh() {
    _pageIndex = 1;
    _searchGoodViewModel.searchGoods(_keyController.text.toString(), _pageIndex,
        _pageSize, _sortName, _orderType);
  }

  ///加载更多
  _onLoadMore() async {
    _searchGoodViewModel.searchGoods(_keyController.text.toString(), _pageIndex,
        _pageSize, _sortName, _orderType);
  }

  ///排序
  _sort() {
    _focusNode.unfocus();
    _pageIndex = 1;
    _showDialog(context);
    _searchGoodViewModel
        .searchGoods(_keyController.text.toString(), _pageIndex, _pageSize,
            _sortName, _orderType)
        .then((value) => Navigator.pop(context));
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoadingDialog(
            title: AppStrings.LOGINING,
            textColor: AppColors.COLOR_999999,
            titleSize: AppDimens.DIMENS_42,
            indicatorRadius: AppDimens.DIMENS_60,
          );
        });
  }

  @override
  void dispose() {
    _keyController.dispose();
    _refreshController.dispose();
    super.dispose();
  }
}
