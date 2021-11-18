import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/cart_model.dart';
import 'package:flutter_shop/ui/widgets/cached_image.dart';
import 'package:flutter_shop/ui/widgets/card_number.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/refresh_state_util.dart';
import 'package:flutter_shop/view_model/cart_view_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///购物车
class TabCarPage extends StatefulWidget {
  const TabCarPage({Key? key}) : super(key: key);

  @override
  _TabCarPageState createState() => _TabCarPageState();
}

class _TabCarPageState extends State<TabCarPage> {
  final RefreshController _refreshController = RefreshController();

  late CartViewModel _cartViewModel;

  double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
  double dimens20 = ScreenUtil().setWidth(AppDimens.DIMENS_20);
  double dimens200 = ScreenUtil().setWidth(AppDimens.DIMENS_200);

  @override
  void initState() {
    super.initState();
    _cartViewModel = context.read<CartViewModel>();
    print("TabCarPage  initState");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.SHOP_CAR),
          centerTitle: true,
        ),
        body: _contentWidget(model),
        bottomNavigationBar: _bottomWidget(model),
      );
    });
  }

  ///是否显示底部的结算按钮
  _bottomWidget(CartViewModel model) {
    return model.isShowBottomView
        ? Container(
            height: ScreenUtil().setHeight(AppDimens.DIMENS_180),
            decoration: const ShapeDecoration(
                shape: Border(
                    top:
                        BorderSide(color: AppColors.COLOR_F0F0F0, width: 1.0))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                    value: model.isAllCheck,
                    activeColor: AppColors.COLOR_FF5722,
                    onChanged: (value) {
//                      _cartViewModel _setCartItemCheck(bool);
                      _setCheckAll(value!);
                    }),
                SizedBox(
                  width: ScreenUtil().setWidth(AppDimens.DIMENS_240),
                  child: Text(AppStrings.TOTAL_MONEY +
                      "${model.cartModel!.cartTotal!.checkedGoodsAmount}"),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(
                      right: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    onPressed: () {
                      //todo 下单界面
                      NavigatorUtil.goFillInOrder(context, 0);
                    },
                    color: AppColors.COLOR_FF5722,
                    child: Text(
                      AppStrings.GO_PAY,
                      style: TextStyle(
                          color: AppColors.COLOR_FFFFFF,
                          fontSize: ScreenUtil().setSp(AppDimens.DIMENS_42)),
                    ),
                  ),
                ))
              ],
            ),
          )
        : Container(
            height: 0,
          );
  }

  ///设置全选或者全不选
  _setCheckAll(bool selected) {
    List<int> ids = [];
    List<CartBean> cartList = _cartViewModel.cartModel!.cartList!;
    for (CartBean item in cartList) {
      if (item.checked != selected) {
        ids.add(item.productId!);
      }
    }
    _cartViewModel.checkAllCartItem(ids, selected);
  }

  ///购物车 body 内容数据
  Widget _contentWidget(CartViewModel model) {
    return SmartRefresher(
      header: const WaterDropMaterialHeader(
          backgroundColor: AppColors.COLOR_FF5722),
      controller: _refreshController,
      onRefresh: () {
        _onRefresh(model);
      },
      child: _initBodyView(model),
    );
  }

  ///刷新时护具
  _onRefresh(CartViewModel model) async {
    await model.queryCart();
  }

  Widget _initBodyView(CartViewModel model) {
    RefreshStateUtil.getInstance().stopRefreshOrLoadMore(_refreshController);
    if (model.pageState == PageState.hasData) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return _cartItemView(model.cartModel!.cartList![index], index, model);
        },
        itemCount: model.cartModel!.cartList?.length,
      );
    }
    return PageStatusWidget.stateWidgetWithCallBack(model, () {
      _onRefresh(model);
    });
  }

  ///每个 Item 的样式
  _cartItemView(CartBean cartBean, int index, CartViewModel model) {
    return Container(
      margin: EdgeInsets.only(left: dimens30, right: dimens30, top: dimens20),
      height: ScreenUtil().setHeight(AppDimens.DIMENS_300),
      width: double.infinity,
      child: Card(
        //可以在指定轴的两个方向上滑动的小部件,滑动删除，用法：https://pub.dev/packages/flutter_slidable
        child: Slidable(
          //定义右边的滑动显示
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  _deleteDialog(cartBean.productId!, index);
                },
                foregroundColor: AppColors.COLOR_FF5722,
                icon: Icons.delete,
                label: AppStrings.DELETE,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                  value: cartBean.checked ?? true,
                  activeColor: AppColors.COLOR_FF5722,
                  hoverColor: AppColors.COLOR_FF5722,
                  onChanged: (value) {
                    _cartViewModel.checkCartItem(cartBean.productId!, value!);
                  }),
              CachedImageView(dimens200, dimens200, cartBean.picUrl!),
              Padding(padding: EdgeInsets.only(left: dimens20)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(cartBean.goodsName!,
                        style: FMTextStyle.color_333333_size_42),
                    Padding(padding: EdgeInsets.only(top: dimens20)),
                    Text(
                      "${AppStrings.SPECIFICATIONS}${cartBean.specifications![0]}",
                      style: FMTextStyle.color_999999_size_36,
                    ),
                    Padding(padding: EdgeInsets.only(top: dimens20)),
                    Row(
                      children: [
                        Text("${AppStrings.DOLLAR}${cartBean.price}",
                            style: FMTextStyle.color_ff5722_size_42),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(
                              right: ScreenUtil().setWidth(20.0)),
                          alignment: Alignment.centerRight,
                          child: CartNumberView(
                              number: cartBean.number!,
                              callback: (value) {
                                //todo 有 bug 需要优化
                                print(value);
                                //更新购物车状态
                                _cartViewModel.updateCartItem(
                                    cartBean.id!,
                                    value,
                                    cartBean.productId!,
                                    cartBean.goodsId!,
                                    index);
                              }),
                        ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///删除购物车商品的弹窗
  _deleteDialog(int productId, int index) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(AppStrings.TIPS),
            content: const Text(AppStrings.DELETE_CART_ITEM_TIPS),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppStrings.CANCEL,
                    style: FMTextStyle.color_999999_size_42),
              ),
              TextButton(
                onPressed: () {
                  _deleteCartItem(productId, index);
                },
                child: Text(AppStrings.CONFIRM,
                    style: FMTextStyle.color_ff5722_size_42),
              )
            ],
          );
        });
  }

  _deleteCartItem(int productId, int index) {
    _cartViewModel.deleteCartGoods([productId], index).then((response) => {
          if (response) {Navigator.pop(context)}
        });
  }
}
