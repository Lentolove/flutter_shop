import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/event/order_refresh_event.dart';
import 'package:flutter_shop/model/order_detail_model.dart';
import 'package:flutter_shop/model/order_list_model.dart';
import 'package:flutter_shop/ui/widgets/divider_line.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/refresh_state_util.dart';
import 'package:flutter_shop/view_model/order_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///订单类表界面
class OrderListPage extends StatefulWidget {
  //页面显示类型
  final int showType;

  const OrderListPage({Key? key, required this.showType}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

///防止页面重建
class _OrderListPageState extends State<OrderListPage>
    with AutomaticKeepAliveClientMixin {
  final OrderViewModel _orderViewModel = OrderViewModel();

  final RefreshController _refreshController = RefreshController();

  int _pageIndex = 1;

  int _pageSize = 10;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _orderViewModel.queryOrder(widget.showType, _pageIndex, _pageSize);
  }

  @override
  Widget build(BuildContext context) {
    orderEventBus.on<OrderRefreshEvent>().listen((event) {
      _pageIndex = 1;
      _pageSize = 20;
      _orderViewModel.queryOrder(widget.showType, _pageIndex, _pageSize);
    });
    return Material(
        child: ChangeNotifierProvider(
            create: (_) => _orderViewModel,
            child: Consumer<OrderViewModel>(builder: (context, model, child) {
              print(_pageIndex);
              _pageIndex = model.canLoadMore ? ++_pageIndex : _pageIndex;
              print(_pageIndex);
              print(_orderViewModel.canLoadMore);
              print(model.canLoadMore);
              RefreshStateUtil.getInstance()
                  .stopRefreshOrLoadMore(_refreshController);
              return _initView(model);
            })));
  }

  double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);

  //显示视图数据
  _initView(OrderViewModel model) {
    if (model.pageState == PageState.hasData) {
      return _contentWidget(model);
    }
    return PageStatusWidget.stateWidgetWithCallBack(model, () {
      _onRefresh();
    });
  }

  //显示订单视图
  _contentWidget(OrderViewModel model) {
    return Container(
        margin: EdgeInsets.only(left: dimens30, right: dimens30),
        child: SmartRefresher(
          onRefresh: () => _onRefresh(),
          onLoading: () => _onLoadMore(),
          enablePullDown: true,
          enablePullUp: model.canLoadMore,
          header: const ClassicHeader(),
          controller: _refreshController,
          child: ListView.builder(
              itemCount: model.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _orderItemWidget(model.data[index]);
                // return Text("data");
              }),
        ));
  }

  //每一个订单视图
  _orderItemWidget(OrderModel order) {
    return Card(
        child: InkWell(
            onTap: () => NavigatorUtil.goOrderDetailPage(context, order.id!),
            child: Container(
              margin: EdgeInsets.all(dimens30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppStrings.ORDER_STATUS,
                        style: TextStyle(
                            color: AppColors.COLOR_333333,
                            fontSize: ScreenUtil().setSp(AppDimens.DIMENS_42)),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left:
                                  ScreenUtil().setWidth(AppDimens.DIMENS_20))),
                      Expanded(
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${order.orderStatusText}"),
                                ],
                              )))
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: order.goodsList?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return _goodItem(
                            order.goodsList![index],
                            order.goodsList!.length == 1 ||
                                index == order.goodsList!.length);
                      }),
                  Container(
                      margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(AppDimens.DIMENS_20),
                          left: ScreenUtil().setWidth(AppDimens.DIMENS_20),
                          top: ScreenUtil().setHeight(AppDimens.DIMENS_20)),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                              AppStrings.MINE_ORDER_TOTAL_GOODS +
                                  "${goodNumber(order.goodsList!)}" +
                                  AppStrings.MINE_ORDER_GOODS_TOTAL,
                              style: FMTextStyle.color_999999_size_36),
                          Padding(
                              padding: EdgeInsets.only(left: dimens30),
                              child: Text(
                                  AppStrings.MINE_ORDER_PRICE +
                                      "${order.actualPrice}",
                                  style: FMTextStyle.color_ff5722_size_42)),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                    visible: order.handleOption!.delete!,
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: dimens30, right: dimens30),
                                        height: ScreenUtil()
                                            .setHeight(AppDimens.DIMENS_80),
                                        width: ScreenUtil()
                                            .setWidth(AppDimens.DIMENS_200),
                                        child: RaisedButton(
                                          padding: EdgeInsets.zero,
                                          splashColor: AppColors.COLOR_FFFFFF,
                                          highlightColor:
                                              AppColors.COLOR_FFFFFF,
                                          highlightElevation: 0,
                                          child: Text(
                                            AppStrings.DELETE,
                                            style: FMTextStyle
                                                .color_333333_size_42,
                                          ),
                                          onPressed: () =>
                                              _showDialog(2, order.id!),
                                          elevation: 0,
                                          shape: const RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color:
                                                      AppColors.COLOR_DBDBDB),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      AppDimens.DIMENS_30))),
                                          color: AppColors.COLOR_FFFFFF,
                                        ))),
                                Visibility(
                                    visible: order.handleOption!.cancel!,
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: dimens30, right: dimens30),
                                        height: ScreenUtil()
                                            .setHeight(AppDimens.DIMENS_80),
                                        width: ScreenUtil()
                                            .setWidth(AppDimens.DIMENS_200),
                                        child: RaisedButton(
                                          padding: EdgeInsets.zero,
                                          splashColor: AppColors.COLOR_FFFFFF,
                                          highlightColor:
                                              AppColors.COLOR_FFFFFF,
                                          highlightElevation: 0,
                                          child: Text(
                                            AppStrings.CANCEL,
                                            style: FMTextStyle
                                                .color_333333_size_42,
                                          ),
                                          onPressed: () =>
                                              _showDialog(1, order.id!),
                                          elevation: 0,
                                          shape: const RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color:
                                                      AppColors.COLOR_DBDBDB),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      AppDimens.DIMENS_30))),
                                          color: AppColors.COLOR_FFFFFF,
                                        )))
                              ],
                            ),
                          ))
                        ],
                      ))
                ],
              ),
            )));
  }

  //每个商品视图
  _goodItem(OrderGoodModel model, bool isLast) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              model.picUrl!,
              width: ScreenUtil().setWidth(AppDimens.DIMENS_300),
              height: ScreenUtil().setHeight(AppDimens.DIMENS_300),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(AppDimens.DIMENS_30),
                    top: ScreenUtil().setHeight(AppDimens.DIMENS_30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(model.goodsName ?? "",
                        style: FMTextStyle.color_333333_size_42),
                    Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(AppDimens.DIMENS_20))),
                    Text(
                      model.specifications?[0] ?? "",
                      style: FMTextStyle.color_999999_size_42,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(AppDimens.DIMENS_20))),
                    Row(
                      children: [
                        Text(
                          AppStrings.DOLLAR + "${model.price}",
                          style: FMTextStyle.color_ff5722_size_42,
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "x${model.number}",
                            style: FMTextStyle.color_999999_size_36,
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Offstage(
          offstage: isLast,
          child: Container(
            margin: EdgeInsets.only(left: dimens30),
            child: const DividerLineView(),
          ),
        )
      ],
    );
  }

  //弹窗确认
  _showDialog(int action, int orderId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppStrings.TIPS,
              style: FMTextStyle.color_333333_size_48,
            ),
            content: Text(
              action == 1
                  ? AppStrings.MINE_ORDER_CANCEL_TIPS
                  : AppStrings.MINE_ORDER_DELETE_TIPS,
              style: FMTextStyle.color_333333_size_42,
            ),
            actions: <Widget>[
              FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.CANCEL,
                    style: FMTextStyle.color_ff5722_size_42,
                  )),
              FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                    if (action == 1) {
                      _cancelOrder(orderId);
                    } else {
                      _deleteOrder(orderId);
                    }
                  },
                  child: Text(
                    AppStrings.CONFIRM,
                    style: FMTextStyle.color_333333_size_42,
                  )),
            ],
          );
        });
  }

  //刷新订单
  _onRefresh() {
    _pageIndex = 1;
    _orderViewModel.queryOrder(widget.showType, _pageIndex, _pageSize);
  }

  //加载更多订单
  _onLoadMore() {
    _orderViewModel.queryOrder(widget.showType, _pageIndex, _pageSize);
  }

  //取消订单
  _cancelOrder(int orderId) {
    _orderViewModel.cancelOrder(orderId).then((value) {
      if (value) {
         orderEventBus.fire(OrderRefreshEvent());
        Navigator.pop(context);
      }
    });
  }

  //删除订单
  _deleteOrder(int orderId) {
    _orderViewModel.deleteOrder(orderId).then((value) {
      if (value) {
        orderEventBus.fire(OrderRefreshEvent());
        Navigator.pop(context);
      }
    });
  }

  //商品数量
  int goodNumber(List<OrderGoodModel> order) {
    int number = 0;
    for (var item in order) {
      number += item.number ?? 0;
    }
    return number;
  }
}
