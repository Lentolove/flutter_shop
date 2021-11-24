import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_images.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/event/order_refresh_event.dart';
import 'package:flutter_shop/model/order_detail_model.dart';
import 'package:flutter_shop/ui/widgets/divider_line.dart';
import 'package:flutter_shop/ui/widgets/item_text.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/view_model/order_detail_view_model.dart';
import 'package:flutter_shop/view_model/order_view_model.dart';
import 'package:provider/provider.dart';

//订单详情界面
class OrderDetailPage extends StatefulWidget {
  final int orderId;

  const OrderDetailPage({Key? key, required this.orderId}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  //订单详情
  final OrderDetailViewModel _orderDetailViewModel = OrderDetailViewModel();

  //管理订单
  final OrderViewModel _orderViewModel = OrderViewModel();

  @override
  void initState() {
    super.initState();
    _orderDetailViewModel.queryOrderDetail(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.MINE_ORDER_DETAIL),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (_) => _orderDetailViewModel,
        child: Consumer<OrderDetailViewModel>(builder: (context, model, child) {
          return _initView(model);
        }),
      ),
    );
  }

  //页面数据展示
  Widget _initView(OrderDetailViewModel model) {
    if (model.pageState == PageState.hasData) {
      return _contentWidget(model);
    }
    return PageStatusWidget.stateWidget(model);
  }

  //数据展示视图
  _contentWidget(OrderDetailViewModel orderDetailViewModel) {
    OrderDetailModel detailModel = orderDetailViewModel.orderDetailModel!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _addressWidget(detailModel),
              const DividerLineView(),
              _orderGoodsWidget(detailModel),
              const DividerLineView(),
              _goodsPriceInfo(detailModel),
              _goodInformation(detailModel)
            ]),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: detailModel.orderInfo!.handleOption!.delete!,
            child: Container(
                width: ScreenUtil().setWidth(AppDimens.DIMENS_480),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(AppDimens.DIMENS_30),
                    right: ScreenUtil().setWidth(AppDimens.DIMENS_20)),
                child: RaisedButton(
                  splashColor: AppColors.COLOR_FFFFFF,
                  highlightColor: AppColors.COLOR_FFFFFF,
                  highlightElevation: 0,
                  child: Text(
                    AppStrings.DELETE,
                    style: FMTextStyle.color_333333_size_42,
                  ),
                  onPressed: () =>
                      _showDialog(2, detailModel.orderInfo!.id!),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.COLOR_DBDBDB),
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppDimens.DIMENS_30))),
                  color: AppColors.COLOR_FFFFFF,
                )),
          ),
          Visibility(
            visible: detailModel.orderInfo!.handleOption!.cancel!,
            child: Container(
                width: ScreenUtil().setWidth(AppDimens.DIMENS_480),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(AppDimens.DIMENS_30),
                    right: ScreenUtil().setWidth(AppDimens.DIMENS_20)),
                child: RaisedButton(
                  splashColor: AppColors.COLOR_FFFFFF,
                  highlightColor: AppColors.COLOR_FFFFFF,
                  highlightElevation: 0,
                  child: Text(
                    AppStrings.CANCEL,
                    style: FMTextStyle.color_333333_size_42,
                  ),
                  onPressed: () =>
                      _showDialog(1, detailModel.orderInfo!.id!),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.COLOR_DBDBDB),
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppDimens.DIMENS_30))),
                  color: AppColors.COLOR_FFFFFF,
                )),
          )
        ],
      ),
    );
  }

  ///地址信息
  _addressWidget(OrderDetailModel model) {
    return Container(
      color: AppColors.COLOR_FFFFFF,
      padding: EdgeInsets.all(ScreenUtil().setWidth(AppDimens.DIMENS_30)),
      child: Row(
        children: [
          Container(
            width: ScreenUtil().setWidth(AppDimens.DIMENS_180),
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.ORDER_LOCATION,
              width: ScreenUtil().setWidth(AppDimens.DIMENS_100),
              height: ScreenUtil().setWidth(AppDimens.DIMENS_100),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(AppDimens.DIMENS_20)),
                      child: Text(
                        model.orderInfo?.consignee ?? "",
                        style: FMTextStyle.color_333333_size_42,
                      )),
                  Text(model.orderInfo?.mobile ?? "",
                      style: FMTextStyle.color_333333_size_42)
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(AppDimens.DIMENS_30)),
                  child: Text(model.orderInfo?.address ?? "",
                      style: FMTextStyle.color_333333_size_42))
            ],
          )
        ],
      ),
    );
  }

  ///订单信息
  _orderGoodsWidget(OrderDetailModel model) {
    return Container(
      color: AppColors.COLOR_FFFFFF,
      padding: EdgeInsets.all(ScreenUtil().setWidth(AppDimens.DIMENS_30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: ScreenUtil().setHeight(AppDimens.DIMENS_80),
                child: Text(
                  AppStrings.APP_NAME,
                  style: FMTextStyle.color_333333_size_42,
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  model.orderInfo?.orderStatusText ?? "",
                  style: FMTextStyle.color_ff5722_size_42,
                ),
              )),
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: model.orderGoods?.length,
              itemBuilder: (BuildContext context, int index) {
                return _goodItemWidget(
                    model.orderGoods![index],
                    model.orderGoods!.length == 1 ||
                        index == model.orderGoods!.length);
              })
        ],
      ),
    );
  }

  //订单商品的视图
  _goodItemWidget(OrderGood good, bool showLine) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              good.picUrl!,
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
                    Text(good.goodsName ?? "",
                        style: FMTextStyle.color_333333_size_42),
                    Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(AppDimens.DIMENS_20))),
                    Text(
                      good.specifications?[0] ?? "",
                      style: FMTextStyle.color_999999_size_42,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(AppDimens.DIMENS_20))),
                    Row(
                      children: [
                        Text(
                          AppStrings.DOLLAR + "${good.price}",
                          style: FMTextStyle.color_ff5722_size_42,
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "x${good.number}",
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
          offstage: showLine,
          child: Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
            child: const DividerLineView(),
          ),
        )
      ],
    );
  }

  //订单信息详情视图
  _goodsPriceInfo(OrderDetailModel model) {
    return Container(
      color: AppColors.COLOR_FFFFFF,
      child: Column(
        children: [
          ItemTextView(
              leftText: AppStrings.MINE_ORDER_DETAIL_TOTAL,
              rightText: AppStrings.DOLLAR + "${model.orderInfo?.goodsPrice}"),
          const DividerLineView(),
          ItemTextView(
              leftText: AppStrings.FREIGHT,
              rightText:
                  AppStrings.DOLLAR + "${model.orderInfo?.freightPrice}"),
          const DividerLineView(),
          ItemTextView(
              leftText: AppStrings.MINE_ORDER_DETAIL_PREFERENCES,
              rightText: AppStrings.DOLLAR + "${model.orderInfo?.couponPrice}"),
          const DividerLineView(),
          ItemTextView(
              leftText: AppStrings.MINE_ORDER_DETAIL_PAYMENTS,
              rightText: AppStrings.DOLLAR + "${model.orderInfo?.actualPrice}"),
        ],
      ),
    );
  }

  //订单编号和订单时间
  _goodInformation(OrderDetailModel model) {
    return Container(
      color: AppColors.COLOR_FFFFFF,
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(AppDimens.DIMENS_30)),
      child: Column(
        children: [
          ItemTextView(
              leftText: AppStrings.MINE_ORDER_SN,
              rightText: model.orderInfo?.orderSn ?? ""),
          const DividerLineView(),
          ItemTextView(
              leftText: AppStrings.MINE_ORDER_TIME,
              rightText: model.orderInfo?.addTime ?? ""),
        ],
      ),
    );
  }

  //显示弹窗
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
}
