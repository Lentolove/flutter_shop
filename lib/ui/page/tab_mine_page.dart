import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_images.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/ui/widgets/divider_line.dart';
import 'package:flutter_shop/ui/widgets/icon_text_arrow_view.dart';
import 'package:flutter_shop/utils/shared_preferences_util.dart';
import 'package:flutter_shop/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

///我的 tab
class TabMinePage extends StatefulWidget {
  const TabMinePage({Key? key}) : super(key: key);

  @override
  _TabMinePageState createState() => _TabMinePageState();
}

class _TabMinePageState extends State<TabMinePage> {
  double dimens80 = ScreenUtil().setWidth(AppDimens.DIMENS_80);
  double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
  double dimens20 = ScreenUtil().setWidth(AppDimens.DIMENS_20);
  double dimens10 = ScreenUtil().setWidth(AppDimens.DIMENS_10);
  double dimens100 = ScreenUtil().setWidth(AppDimens.DIMENS_100);
  double dimens180 = ScreenUtil().setWidth(AppDimens.DIMENS_180);

  @override
  void initState() {
    super.initState();
    print("TabMinePage  initState");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, model, child) {
      return _contentWidget(model);
    });
  }

  Widget _contentWidget(UserViewModel model) {
    return Stack(
      children: [
        Container(
          height: ScreenUtil().setHeight(AppDimens.DIMENS_600) +
              MediaQuery.of(context).padding.top,
          decoration: BoxDecoration(
              //设置渐变色
              gradient: const LinearGradient(
                  colors: [AppColors.COLOR_FFB24E, AppColors.COLOR_FF5722]),
              color: AppColors.COLOR_FF5722,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(dimens80),
                  bottomRight: Radius.circular(dimens80))),
        ),
        Container(
          padding: EdgeInsets.all(dimens30),
          margin: EdgeInsets.only(top: dimens100),
          child: Column(
            children: [
              _headerWidget(model),
              _userDataWidget(model),
              _userOrderWidget(),
              _userInfoWidget(),
              _logoutWidget()
            ],
          ),
        ),
      ],
    );
  }

  ///个人信息,左边头像，右边用户名和VIP
  _headerWidget(UserViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: dimens180,
            height: dimens180,
            margin: EdgeInsets.only(left: dimens30),
            child: CircleAvatar(
              radius: ScreenUtil().setWidth(AppDimens.DIMENS_90),
              backgroundImage:
                  NetworkImage(model.pictureUrl ?? AppStrings.DEFAULT_URL),
            )),
        Padding(padding: EdgeInsets.only(left: dimens30)),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.userName ?? "---",
                style: FMTextStyle.color_ffffff_size_42),
            Text(
              AppStrings.SUPER_VIP,
              style: FMTextStyle.color_ffffff_size_36,
            ),
          ],
        ),
      ],
    );
  }

  ///用户商品信息
  _userDataWidget(UserViewModel model) {
    return Container(
      margin: EdgeInsets.only(top: dimens30),
      child: Row(
        children: [
          /*优惠券*/
          Expanded(
              flex: 1,
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${model.couponNumber}",
                        style: FMTextStyle.color_ffffff_size_42),
                    Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(AppDimens.DIMENS_30))),
                    Text(AppStrings.COUPON,
                        style: FMTextStyle.color_ffffff_size_42),
                  ],
                ),
                onTap: () => {
                  // todo  跳转到优惠券界面
                },
              )),
          /*收藏*/
          Expanded(
              flex: 1,
              child: InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${model.collectionNumber}",
                          style: FMTextStyle.color_ffffff_size_42),
                      Padding(
                          padding: EdgeInsets.only(
                              top:
                                  ScreenUtil().setHeight(AppDimens.DIMENS_30))),
                      Text(AppStrings.COLLECTION,
                          style: FMTextStyle.color_ffffff_size_42),
                    ],
                  ),
                  onTap: () => {
                        // todo 跳转到收藏页面
                      })),
          /*我的足迹*/
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => {
                  //todo 跳转到我的足迹
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${model.footPrintfNumber}",
                        style: FMTextStyle.color_ffffff_size_42),
                    Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(AppDimens.DIMENS_30))),
                    Text(AppStrings.MINE_FOOTPRINT,
                        style: FMTextStyle.color_ffffff_size_42),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  ///我的订单管理
  _userOrderWidget() {
    return Container(
      margin: EdgeInsets.all(dimens10),
      child: Card(
        color: AppColors.COLOR_FFFFFF,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppDimens.DIMENS_10))),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: dimens30, right: dimens30),
              alignment: Alignment.centerLeft,
              height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
              child: Row(
                children: [
                  /*我的订单*/
                  Text(AppStrings.MINE_ORDER,
                      style: FMTextStyle.color_333333_size_42),
                  /*查看全部订单*/
                  Expanded(
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            splashColor: AppColors.COLOR_FFFFFF,
                            highlightColor: AppColors.COLOR_FFFFFF,
                            onTap: () => {
                              //todo 跳转到全部订单
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(AppStrings.CHECK_ALL_ORDER,
                                    style: FMTextStyle.color_999999_size_36),
                                Image.asset(
                                  AppImages.ARROW_RIGHT,
                                  width: dimens30,
                                  height: dimens30,
                                ),
                              ],
                            ),
                          )))
                ],
              ),
            ),
            /*分割线*/
            const DividerLineView(),
            /*四个界面*/
            Container(
              margin: EdgeInsets.only(top: dimens30),
              height: ScreenUtil().setHeight(AppDimens.DIMENS_190),
              child: Row(
                children: [
                  _orderItem(AppImages.TO_BE_PAID, AppStrings.TO_BE_PAID, 1),
                  //待付款
                  _orderItem(
                      AppImages.TO_BE_DELIVERED, AppStrings.TO_BE_DELIVERED, 2),
                  //待发货
                  _orderItem(AppImages.RECEIVED, AppStrings.TO_BE_RECEIVED, 1),
                  //待收货
                  _orderItem(
                      AppImages.TO_BE_EVALUATED, AppStrings.TO_BE_EVALUATED, 1),
                  //待评价
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _orderItem(String iconUrl, String title, int index) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            //todo 跳转到对应的界面
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconUrl,
                width: dimens100,
                height: dimens100,
              ),
              Padding(padding: EdgeInsets.only(top: dimens20)),
              Text(title, style: FMTextStyle.color_333333_size_36),
            ],
          ),
        ));
  }

  //其它信息：地址管理 + 反馈 + 关于我们
  _userInfoWidget() {
    return Container(
        margin: EdgeInsets.all(dimens10),
        child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppDimens.DIMENS_10))),
            child: Container(
              padding: EdgeInsets.only(left: dimens20, right: dimens20),
              child: Column(
                children: [
                  /*地址管理，自定义 IconTextArrowView 布局 */
                  IconTextArrowView(
                      iconUrl: AppImages.LOCATION,
                      title: AppStrings.LOCATION,
                      callback: () {
                        //todo 跳转到地址管理界面
                      }),
                  const DividerLineView(),
                  IconTextArrowView(
                      iconUrl: AppImages.FEEDBACK,
                      title: AppStrings.FEED_BACK,
                      callback: () {
                        //todo 跳转到反馈界面
                      }),
                  const DividerLineView(),
                  IconTextArrowView(
                      iconUrl: AppImages.ABOUT_US,
                      title: AppStrings.ABOUT_US,
                      callback: () {
                        //todo 跳转到反馈界面
                      }),
                ],
              ),
            )));
  }

  ///退出登录按钮
  _logoutWidget() {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
      child: ElevatedButton(
        onPressed: () {
          //todo 退出登录
          _logout();
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(8))),
            backgroundColor: MaterialStateProperty.all(AppColors.COLOR_FF5722)),
        child: Text(AppStrings.LOGOUT, style: FMTextStyle.color_ffffff_size_42),
      ),
    );
  }

  //退出登录弹窗提示
  _logout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text(AppStrings.TIPS, style: FMTextStyle.color_333333_size_60),
            content: Text(AppStrings.CONFIRM_LOGOUT,
                style: FMTextStyle.color_333333_size_48),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppStrings.CANCEL,
                      style: FMTextStyle.color_999999_size_42)),
              TextButton(
                  onPressed: () {
                    SharedPreferencesUtil.instance.clear().then((value) {
                      print(value);
                      if (value) {
                        Navigator.pop(context);
                        Provider.of<UserViewModel>(context, listen: false)
                            .refreshData();

                        //todo 更新购物车界面 tabSelectBus.fire(TabSelectEvent(0));
                      }
                    });
                  },
                  child: Text(AppStrings.CONFIRM,
                      style: FMTextStyle.color_ff5722_size_42)),
            ],
          );
        });
  }
}
