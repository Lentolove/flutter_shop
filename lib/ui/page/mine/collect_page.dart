import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/collection_model.dart';
import 'package:flutter_shop/ui/widgets/cached_image.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/refresh_state_util.dart';
import 'package:flutter_shop/view_model/collect_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///收藏界面
class CollectPage extends StatefulWidget {
  const CollectPage({Key? key}) : super(key: key);

  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {

  final CollectViewModel _collectViewModel = CollectViewModel();
  final RefreshController _refreshController = RefreshController();

  int _pageIndex = 1;

  int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    print("initState CollectPage");
    _collectViewModel.queryData(_pageIndex, _pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.MINE_COLLECT),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider.value(
          value: _collectViewModel,
          child: Consumer<CollectViewModel>(builder: (context, model, child) {
            _pageIndex = model.canLoadMore ? ++_pageIndex : _pageIndex;
            RefreshStateUtil.getInstance()
                .stopRefreshOrLoadMore(_refreshController);
            return _initView(model);
          }),
        ));
  }

  Widget _initView(CollectViewModel model) {
    if (model.pageState == PageState.hasData) {
      return _contentView(model);
    }
    return  PageStatusWidget.stateWidgetWithCallBack(
        model, _onRefresh);
  }

  //body视图
  _contentView(CollectViewModel model){
    return Container(
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(AppDimens.DIMENS_30),
            right: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
        child: SmartRefresher(
          onRefresh: () => _onRefresh(),
          onLoading: () => _onLoadMores(),
          enablePullUp: model.canLoadMore,
          header: const WaterDropMaterialHeader(
            backgroundColor: AppColors.COLOR_FF5722,
          ),
          controller: _refreshController,
          child: GridView.builder(
              itemCount: model.collectionList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return _goodItemWidget(model.collectionList[index], index);
              }),
        ));
  }

  _goodItemWidget(CollectionItem item,int index){
    return GestureDetector(
      child: Card(
        child: Container(
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
                  child: Text(
                    item.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FMTextStyle.color_333333_size_42,
                  ),
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
      ),
      onTap: () {
        NavigatorUtil.goGoodsDetails(context, item.valueId!);
      },
      onLongPress: () => _showDeleteDialog(item),
    );
  }

  //长按弹窗删除,取消收藏
  _showDeleteDialog(CollectionItem item){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppStrings.TIPS,
              style: FMTextStyle.color_333333_size_48,
            ),
            content: Text(
              AppStrings.MINE_CANCEL_COLLECT,
              style: FMTextStyle.color_333333_size_42,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    //todo 取消收藏
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.CANCEL,
                    style: FMTextStyle.color_999999_size_42,
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    //_cancelCollect(collect.valueId, index);
                  },
                  child: Text(
                    AppStrings.CONFIRM,
                    style: FMTextStyle.color_ff5722_size_42,
                  )),
            ],
          );
        });
  }

  _onRefresh() {
    _pageIndex = 1;
    _collectViewModel.queryData(_pageIndex, _pageSize);
  }

  _onLoadMores() {
    _collectViewModel.queryData(_pageIndex, _pageSize);
  }
}
