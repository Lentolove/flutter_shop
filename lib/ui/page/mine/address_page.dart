import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/address_model.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/refresh_state_util.dart';
import 'package:flutter_shop/view_model/address_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//地址列表界面
class AddressPage extends StatefulWidget {
  final int type;

  const AddressPage({Key? key, required this.type}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final AddressViewModel _addressViewModel = AddressViewModel();

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _addressViewModel.queryAddressData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.MY_ADDRESS),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
              child: Container(
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(10.0)),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () => _goAddressEdit(0),
              child: const Text(AppStrings.ADD_ADDRESS),
            ),
          ))
        ],
      ),
      body: ChangeNotifierProvider<AddressViewModel>(
        create: (context) => _addressViewModel,
        child: Consumer<AddressViewModel>(
          builder: (context, model, child) {
            RefreshStateUtil.getInstance()
                .stopRefreshOrLoadMore(_refreshController);
            return SmartRefresher(
              header: const WaterDropMaterialHeader(
                  backgroundColor: AppColors.COLOR_FF5722),
              controller: _refreshController,
              onRefresh: () => _onRefresh(),
              child: _initView(model),
            );
          },
        ),
      ),
    );
  }

  _initView(AddressViewModel model) {
    if (model.pageState == PageState.hasData) {
      return _contentWidget(model);
    }
    return PageStatusWidget.stateWidgetWithCallBack(model, _onRefresh);
  }

  //数据视图
  _contentWidget(AddressViewModel model) {
    return ListView.builder(
        itemCount: model.address.length,
        itemBuilder: (BuildContext context, int index) {
          return _addressItemWidget(model.address[index]);
        });
  }

  double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);

  //每个地址视图
  _addressItemWidget(AddressItem item) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: dimens30, right: dimens30),
      child: Card(
        child: Container(
          padding: EdgeInsets.only(top: dimens30, bottom: dimens30),
          child: InkWell(
            highlightColor: AppColors.COLOR_FFFFFF,
            splashColor: AppColors.COLOR_FFFFFF,
            onTap: _goFillInOrder(item),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: dimens30, right: dimens30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(AppDimens.DIMENS_60)),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.grey,
                      width: ScreenUtil().setWidth(AppDimens.DIMENS_120),
                      height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
                      child: Text(item.name!.substring(0, 1),
                          style: FMTextStyle.color_ffffff_size_60),
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          item.name ?? "",
                          style: FMTextStyle.color_333333_size_42,
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: ScreenUtil()
                                    .setWidth(AppDimens.DIMENS_20))),
                        Text(
                          item.tel ?? "",
                          style: FMTextStyle.color_999999_size_42,
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: dimens30),
                        child: Text(
                          item.province! +
                              item.city! +
                              item.county! +
                              item.addressDetail!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: FMTextStyle.color_333333_size_42,
                        )),
                  ],
                )),
                InkWell(
                    highlightColor: AppColors.COLOR_FFFFFF,
                    splashColor: AppColors.COLOR_FFFFFF,
                    onTap: () => _goAddressEdit(item.id),
                    child: Container(
                      width: ScreenUtil().setWidth(AppDimens.DIMENS_180),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                          shape: Border(
                              left: BorderSide(
                                  color: AppColors.COLOR_999999,
                                  width: ScreenUtil()
                                      .setWidth(AppDimens.DIMENS_1)))),
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(AppDimens.DIMENS_20)),
                      child: Text(
                        AppStrings.ADDRESS_EDIT,
                        style: FMTextStyle.color_999999_size_42,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  //刷新
  void _onRefresh() {
    _addressViewModel.queryAddressData();
  }

  //跳转到填写订单界面
  _goFillInOrder(AddressItem item) {
    if (widget.type == 1) {
      Navigator.pop(context, Uri.encodeFull(jsonEncode(item)));
    }
  }

  //跳转到地址编辑界面
  _goAddressEdit(var addressId) {
    NavigatorUtil.goAddressEdit(context, addressId).then((value) {
      _addressViewModel.queryAddressData();
    });
  }
}
