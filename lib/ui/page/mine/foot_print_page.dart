import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/foot_print_model.dart';
import 'package:flutter_shop/ui/widgets/cached_image.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/refresh_state_util.dart';
import 'package:flutter_shop/utils/toast_util.dart';
import 'package:flutter_shop/view_model/foot_print_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//足迹界面
class FootPrintPage extends StatefulWidget {
  const FootPrintPage({Key? key}) : super(key: key);

  @override
  _FootPrintPageState createState() => _FootPrintPageState();
}

class _FootPrintPageState extends State<FootPrintPage> {

  final FootPrintViewModel _footPrintViewModel = FootPrintViewModel();

  final RefreshController _refreshController = RefreshController();

  var _pageIndex = 1;

  var _pageSize = 10;


  @override
  void initState() {
    super.initState();
    _footPrintViewModel.queryFootPrint(_pageIndex, _pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FootPrintViewModel>(
      create: (_) => _footPrintViewModel,
      child: Consumer<FootPrintViewModel>(builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
                title: const Text(AppStrings.MINE_FOOTPRINT),
                centerTitle: true,
                actions: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        right: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
                    child: InkWell(
                      onTap: () => _footPrintViewModel.setShowCheckBox(!_footPrintViewModel.isShowCheckBox),
                      child: Text(
                        _footPrintViewModel.isShowCheckBox
                            ? AppStrings.CANCEL
                            : AppStrings.SELECT,
                        style: FMTextStyle.color_ffffff_size_42,
                      ),
                    ),
                  )
                ]),
            body: _initView(model),
            bottomNavigationBar: Visibility(
              visible: _footPrintViewModel.isShowCheckBox &&
                  _footPrintViewModel.footList.isNotEmpty,
              child: Container(
                padding: EdgeInsets.only(
                    bottom: ScreenUtil().setHeight(AppDimens.DIMENS_30),
                    left: ScreenUtil().setWidth(AppDimens.DIMENS_30),
                    right: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
                height: ScreenUtil().setHeight(AppDimens.DIMENS_150),
                child: RaisedButton(
                  color: AppColors.COLOR_FF5722,
                  onPressed: () => _deleteFootPrint(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    AppStrings.DELETE,
                    style: FMTextStyle.color_ffffff_size_48,
                  ),
                ),
              ),
            ));
      }),
    );
  }
  Widget _initView(FootPrintViewModel model) {
    _pageIndex = model.canLoadMore ? ++_pageIndex : _pageIndex;
    RefreshStateUtil.getInstance().stopRefreshOrLoadMore(_refreshController);
    if (model.pageState == PageState.hasData) {
      return _contentWidget(model);
    }
    return  PageStatusWidget.stateWidgetWithCallBack(
        model, _onRefresh);
  }

  _contentWidget(FootPrintViewModel model){
    return Container(
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(AppDimens.DIMENS_30),
            right: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: model.canLoadMore,
          header: const WaterDropMaterialHeader(
            backgroundColor: AppColors.COLOR_FF5722,
          ),
          controller: _refreshController,
          onRefresh: () => _onRefresh(),
          onLoading: () => _onLoadMore(),
          child: GridView.builder(
              itemCount: model.footList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return _goodItemWidget(model.footList[index], index);
              }),
        ));
  }

  //每个商品条目样式
  _goodItemWidget(FootPrintItem item,int index){
    return GestureDetector(
      child: Card(
          child: Stack(
            children: [
              Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      CachedImageView(
                        ScreenUtil().setHeight(AppDimens.DIMENS_400),
                        ScreenUtil().setHeight(AppDimens.DIMENS_400),
                        item.picUrl!,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(AppDimens.DIMENS_20),
                            left: ScreenUtil().setWidth(AppDimens.DIMENS_20),
                            right: ScreenUtil().setWidth(AppDimens.DIMENS_20)),
                        child: Text(item.name ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: FMTextStyle.color_333333_size_42),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(AppDimens.DIMENS_20))),
                      Text(
                        "${AppStrings.DOLLAR}${item.retailPrice}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FMTextStyle.color_ff5722_size_42,
                      ),
                    ],
                  )),
              Positioned(
                top: 0,
                right: 0,
                child: Offstage(
                    offstage: !_footPrintViewModel.isShowCheckBox,
                    child: Checkbox(
                        hoverColor: AppColors.COLOR_999999,
                        value: item.isCheck,
                        onChanged: (isCheck) {
                          _footPrintViewModel.setCheck(index, isCheck!);
                        })),
              )
            ],
          )),
      onTap: () => NavigatorUtil.goGoodsDetails(context, item.goodsId!),
    );
  }

  //删除选中的收藏记录
  _deleteFootPrint() {
    List<int> ids = [];
    for (FootPrintItem  item in _footPrintViewModel.footList) {
      if (item.isCheck!) {
        ids.add(item.id!);
      }
    }
    if (ids.isEmpty) {
      ToastUtil.showToast(AppStrings.PLEASE_SELECT_FOOT_PRINT);
      return;
    }
    _footPrintViewModel.deleteFootPrint(ids).then((response) {
      if (response) {
        ToastUtil.showToast(AppStrings.DELETE_SUCCESS);
      } else {
        ToastUtil.showToast(AppStrings.DELETE_FOOT_PRINT_FAIL);
      }
      _footPrintViewModel.setShowCheckBox(false);
      _onRefresh();
    });
  }


  _onRefresh() {
    _pageIndex = 1;
    _footPrintViewModel.queryFootPrint(_pageIndex, _pageSize);
  }

  _onLoadMore() {
    _footPrintViewModel.queryFootPrint(_pageIndex, _pageSize);
  }
}
