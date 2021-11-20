import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_images.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/fill_in_order_model.dart';
import 'package:flutter_shop/ui/widgets/cached_image.dart';
import 'package:flutter_shop/ui/widgets/divider_line.dart';
import 'package:flutter_shop/ui/widgets/item_text.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/ui/widgets/right_arrow.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/toast_util.dart';
import 'package:flutter_shop/view_model/fill_in_order_view_model.dart';
import 'package:provider/provider.dart';

///填写订单界面
class FillInOrderPage extends StatefulWidget {
  final int cartId;

  FillInOrderPage({Key? key, required this.cartId}) : super(key: key){
    print("FillInOrderPage cartId = $cartId");
  }

  @override
  _FillInOrderPageState createState() => _FillInOrderPageState();
}

class _FillInOrderPageState extends State<FillInOrderPage> {
  final FillInOrderViewModel _model = FillInOrderViewModel();

  //备注
  final TextEditingController _remarkController = TextEditingController();

  double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
  double dimens20 = ScreenUtil().setWidth(AppDimens.DIMENS_20);

  @override
  void initState() {
    super.initState();
    _model.queryFillInOrderData(widget.cartId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FillInOrderViewModel>(
      create: (_) => _model,
      child: Selector<FillInOrderViewModel, FillInOrderModel?>(
        builder: (context, model, child) {
          return _showWidget();
        },
        selector: (BuildContext context,FillInOrderViewModel model) {
          return model.fillInOrderModel;
        },
      ),
    );
  }

  _showWidget() {
    if (_model.pageState == PageState.hasData) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.FILL_IN_ORDER),
          centerTitle: true,
        ),
        body: _contentView(),
        bottomNavigationBar: _bottomBar(),
      );
    }
    return PageStatusWidget.stateWidgetWithCallBack(_model, () {});
  }

  //主体数据
  _contentView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _addressWidget(),
          const DividerLineView(height: AppDimens.DIMENS_9),
          Column(
            children:  _goodItemsList(_model.fillInOrderModel!.checkedGoodsList),
          ),
          const DividerLineView(height: AppDimens.DIMENS_9),
          _remarkWidget(),
          const DividerLineView(height: AppDimens.DIMENS_9),
          _couponWidget(),
          const DividerLineView(),
          ItemTextView(leftText: AppStrings.GOODS_TOTAL, rightText: "${AppStrings.DOLLAR}${_model.fillInOrderModel?.goodsTotalPrice}"),
          const DividerLineView(),
          ItemTextView(leftText: AppStrings.FREIGHT, rightText: "${AppStrings.DOLLAR}${_model.fillInOrderModel?.freightPrice}"),
          const DividerLineView(),
          ItemTextView(leftText: AppStrings.COUPON_TOTAL, rightText: "${AppStrings.DOLLAR}${_model.fillInOrderModel?.couponPrice}"),
        ]
      ),
    );
  }

  //地址视图
  _addressWidget() {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Selector<FillInOrderViewModel, FillInOrderCheckedAddress>(
        builder: (context, data, child) {
          return Container(
              color: AppColors.COLOR_FFFFFF,
              height: ScreenUtil().setHeight(AppDimens.DIMENS_240),
              padding:
                  EdgeInsets.all(ScreenUtil().setWidth(AppDimens.DIMENS_30)),
              child: _model.fillInOrderCheckAddress!.id != 0
                  /*显示地址*/
                  ? InkWell(
                      onTap: () {
                        //添加地址
                        NavigatorUtil.goAddress(context, 1)
                            .then((value) => _model.updateAddress(value));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(_model.fillInOrderCheckAddress!.name!,
                                      style: FMTextStyle.color_333333_size_42),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil()
                                            .setHeight(AppDimens.DIMENS_30)),
                                  ),
                                  Text(_model.fillInOrderCheckAddress!.tel!,
                                      style: FMTextStyle.color_333333_size_42),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil()
                                        .setHeight(AppDimens.DIMENS_20)),
                              ),
                              Text(_getAddressString(),
                                  style: FMTextStyle.color_333333_size_42),
                            ],
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: RightArrow()))
                        ],
                      ),
                    )
                  /*显示选择地址*/
                  : InkWell(
                      onTap: () {
                        //设置地址
                        NavigatorUtil.goAddress(context, 1).then((value) {
                          _model.updateAddress(value);
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(AppStrings.PLEASE_SELECT_ADDRESS,
                              style: FMTextStyle.color_999999_size_42),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: RightArrow()))
                        ],
                      ),
                    ));
        },
        selector: (context, model) {
          return _model.fillInOrderCheckAddress!;
        },
      ),
    );
  }

  //商品列表视图
  _goodItemsList(List<FillInOrderCheckedGoodList>? list) {
    List<Widget> itemList = [];
    if(list == null || list.isEmpty) return itemList;
    for (int i = 0; i < list.length; i++) {
      itemList.add(_goodItemWidget(list[i]));
      //不是最后一个的话就需要加一条横线
      if (i != list.length - 1) {
        itemList.add(const DividerLineView());
      }
    }
    return itemList;
  }

  //每个商品视图
  _goodItemWidget(FillInOrderCheckedGoodList good) {
    return Container(
      color: AppColors.COLOR_FFFFFF,
      padding: EdgeInsets.fromLTRB(dimens30, dimens30, dimens20, dimens20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: dimens20),
            child: CachedImageView(ScreenUtil().setWidth(AppDimens.DIMENS_240),
                ScreenUtil().setWidth(AppDimens.DIMENS_240), good.picUrl!),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(good.goodsName ?? "",
                  style: FMTextStyle.color_333333_size_42),
              Padding(
                padding: EdgeInsets.only(top: dimens20),
                child: Text(
                  good.specifications?[0] ?? "",
                  style: FMTextStyle.color_999999_size_42,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: dimens20, bottom: dimens20),
                  child: Text(
                    "${AppStrings.DOLLAR}${good.price}",
                    style: FMTextStyle.color_ff5722_size_42,
                  )),
            ],
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.only(right: dimens30),
                alignment: Alignment.centerRight,
                child: Text("${AppStrings.GOODS_NUMBER}${good.number}"),
              ))
        ],
      ),
    );
  }

  //备注视图
  _remarkWidget() {
    return Container(
        color: AppColors.COLOR_FFFFFF,
        height: ScreenUtil().setHeight(AppDimens.DIMENS_180),
        width: double.infinity,
        padding: EdgeInsets.all(dimens30),
        child: Row(
          children: [
            Text(AppStrings.REMARK, style: FMTextStyle.color_333333_size_42),
            /*备注信息输入框*/
            Expanded(
                child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(AppDimens.DIMENS_60)),
              height: double.infinity,
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: AppStrings.REMARK_HINT,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: FMTextStyle.color_999999_size_42,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: ScreenUtil().setHeight(AppDimens.DIMENS_1))),
                ),
                style: FMTextStyle.color_333333_size_42,
                controller: _remarkController,
              ),
            ))
          ],
        ));
  }

  //优惠券视图
  _couponWidget() {
    return Container(
      color: AppColors.COLOR_FFFFFF,
      width: double.infinity,
      height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
      padding: EdgeInsets.only(left: dimens30, right: dimens30),
      child: Row(
        children: [
          Image.asset(
            AppImages.COUPON,
            width: ScreenUtil().setWidth(AppDimens.DIMENS_120),
            height: ScreenUtil().setHeight(AppDimens.DIMENS_60),
          ),
          Text(AppStrings.COUPON, style: FMTextStyle.color_333333_size_42),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _model.fillInOrderModel?.availableCouponLength == 0
                  ? Text(AppStrings.NOT_AVAILABLE_COUPON,
                      style: FMTextStyle.color_999999_size_42)
                  : Text(
                      "${_model.fillInOrderModel?.couponPrice}${AppStrings.MONEY_UNIT}",
                      style: FMTextStyle.color_333333_size_42),
              Padding(
                padding: EdgeInsets.only(left: dimens20),
              ),
              RightArrow()
            ],
          ))
        ],
      ),
    );
  }

  //获取地址字符串
  _getAddressString() {
    return "${_model.fillInOrderCheckAddress?.province}"
        "${_model.fillInOrderCheckAddress?.city}"
        "${_model.fillInOrderCheckAddress?.county}"
        "${_model.fillInOrderCheckAddress?.addressDetail}";
  }

  //底部付款 widget
  _bottomBar() {
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.only(left: dimens30),
        color: AppColors.COLOR_F0F0F0,
        height: ScreenUtil().setHeight(AppDimens.DIMENS_150),
        child: Row(
          children: [
            Expanded(
                child: Text(
              "${AppStrings.ACTUAL_PAY}${_model.fillInOrderModel!.orderTotalPrice}",
              style: FMTextStyle.color_333333_size_42,
            )),
            Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(AppDimens.DIMENS_300),
              height: double.infinity,
              child: RaisedButton(
                color: AppColors.COLOR_FF5722,
                onPressed: () => _submitOrder(),
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppDimens.DIMENS_30))),
                child: Text(
                  AppStrings.PAY,
                  style: FMTextStyle.color_ffffff_size_42,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //提交订单
  _submitOrder() {
    if (_model.fillInOrderCheckAddress!.id == 0) {
      ToastUtil.showToast(AppStrings.PLEASE_SELECT_ADDRESS);
      return;
    }
    _model
        .submitOrder(
            _model.fillInOrderModel!.cartId!,
            _model.fillInOrderCheckAddress!.id!,
            _remarkController.value.toString(),
            _model.fillInOrderModel!.couponId!)
        .then((value) {
      if (value) {
        //todo 跳转到下单成功的页面
        NavigatorUtil.goSubmitSuccess(context);
      }
    });
  }

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }
}
