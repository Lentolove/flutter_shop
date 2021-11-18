import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/good_detail_model.dart';
import 'package:flutter_shop/ui/widgets/divider_line.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/shared_preferences_util.dart';
import 'package:flutter_shop/view_model/cart_view_model.dart';
import 'package:flutter_shop/view_model/good_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

import 'good_detail_siwper.dart';

///商品详情界面
class GoodDetailPage extends StatefulWidget {
  final int goodId;

  const GoodDetailPage({Key? key, required this.goodId}) : super(key: key);

  @override
  _GoodDetailPageState createState() => _GoodDetailPageState();
}

class _GoodDetailPageState extends State<GoodDetailPage> {

  final GoodDetailViewModel _model = GoodDetailViewModel();

  late CartViewModel _cartViewModel;

  int _number = 1;

  @override
  void initState() {
    super.initState();
    _cartViewModel = context.read<CartViewModel>();
    _model.getGoodsDetail(widget.goodId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoodDetailViewModel>(
      create: (_) => _model,
      child: Selector<GoodDetailViewModel, GoodDetailModel?>(
          builder: (context, goodDetailModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.GOODS_DETAIL),
            centerTitle: true,
          ),
          body: _showWidget(_model),
          bottomNavigationBar: Selector<GoodDetailViewModel, bool>(
            builder: (context, data, child) {
              return _bottomView(data);
            },
            selector: (context, model) {
              //todo 是否收藏
              return true;
            },
          ),
        );
      }, selector: (context, model) {
        return model.goodDetailModel;
      }),
    );
  }

  double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
  double dimens10 = ScreenUtil().setWidth(AppDimens.DIMENS_10);
  double dimens20 = ScreenUtil().setWidth(AppDimens.DIMENS_20);

  _bottomView(bool isCollection) {
    return BottomAppBar(
      child: SizedBox(
        height: ScreenUtil().setHeight(AppDimens.DIMENS_150),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    //todo 收藏
                  },
                  child: Icon(
                    Icons.star_border,
                    //根据是否收藏来显示不同的颜色
                    color: _model.isCollection
                        ? AppColors.COLOR_FF5722
                        : AppColors.COLOR_999999,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  //todo 添加到购物车
                },
                child: Icon(
                  Icons.add_shopping_cart,
                  color: AppColors.COLOR_FF5722,
                  size: ScreenUtil().setWidth(AppDimens.DIMENS_80),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(left: dimens30, right: dimens30),
                child: FlatButton(
                  padding: const EdgeInsets.all(AppDimens.DIMENS_10),
                  color: AppColors.COLOR_FFB24E,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppDimens.DIMENS_30))),
                  onPressed: (){
                    //todo
                    // openBottomSheet(
                    //     context, _goodsDetailViewModel.goodsDetailEntity, 2),
                    _addCart();
                  },
                  child: Text(AppStrings.ADD_CART,
                      style: FMTextStyle.color_ffffff_size_42),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(left: dimens30, right: dimens30),
                  child: FlatButton(
                    padding: const EdgeInsets.all(AppDimens.DIMENS_10),
                    color: AppColors.COLOR_FFB24E,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppDimens.DIMENS_30))),
                    onPressed: () => {
                      //todo
                      // openBottomSheet(
                      //     context, _goodsDetailViewModel.goodsDetailEntity, 2),
                    },
                    child: Text(AppStrings.BUY,
                        style: FMTextStyle.color_ffffff_size_42),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _showWidget(GoodDetailViewModel model) {
    if (model.pageState == PageState.hasData) {
      print(" _dataView");
      return _dataView(model);
    } else {
      print(" no data");

      return PageStatusWidget.stateWidgetWithCallBack(model, () {
        //todo
      });
    }
  }

  //商品详细界面数据
  _dataView(GoodDetailViewModel model) {
    List<Widget> widgetList = [];
    widgetList.add(GoodDetailSwiper(info: model.goodDetailModel!.info!));
    widgetList.add(const DividerLineView(height: AppDimens.DIMENS_6));
    if (_model.goodDetailModel!.info != null) {
      widgetList.add(_goodDes());
    }

    ///商品参数信息，可能为null
    if (_model.goodDetailModel!.attribute == null ||
        _model.goodDetailModel!.attribute!.isEmpty) {
      widgetList.add((const Divider()));
    } else {
      widgetList.add(_goodAttribute());
    }
    if (_model.goodDetailModel!.info?.detail != null) {
      widgetList.add(Html(data: _model.goodDetailModel!.info?.detail));
    }

    //商品问答描述
    if (_model.goodDetailModel?.issue == null ||
        _model.goodDetailModel!.issue!.isEmpty) {
      widgetList.add((const Divider()));
    } else {
      widgetList.add(_goodIssue(_model.goodDetailModel!.issue!));
    }
    return Container(
      color: AppColors.COLOR_FFFFFF,
      child: SingleChildScrollView(
        child: Column(children: widgetList),
      ),
    );
  }

  //商品问答描述
  _goodIssue(List<GoodDetailIssue> list) {
    return Column(
      children: [
        Text(AppStrings.COMMON_PROBLEM,
            style: FMTextStyle.color_333333_size_42_bold),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return _goodIssueItem(list[index]);
            }),
      ],
    );
  }

  _goodIssueItem(GoodDetailIssue issue) {
    return Container(
        margin: EdgeInsets.all(dimens30),
        padding: EdgeInsets.all(dimens30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(issue.question!, style: FMTextStyle.color_333333_size_42),
            Padding(
              padding: EdgeInsets.only(top: dimens20),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(issue.answer!,
                    style: FMTextStyle.color_999999_size_42)),
          ],
        ));
  }

  _goodAttribute() {
    return Container(
      color: AppColors.COLOR_FFFFFF,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: dimens10),
            child: Text(AppStrings.COMMODITY_PARAMETERS,
                style: FMTextStyle.color_333333_size_42_bold),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _model.goodDetailModel?.attribute?.length,
              itemBuilder: (context, index) {
                return _goodAttributeItem(
                    _model.goodDetailModel?.attribute?[index]);
              }),
        ],
      ),
    );
  }

  ///商品参数的每一列
  _goodAttributeItem(GoodDetailAttribute? attribute) {
    if (attribute == null) return Container();
    return Container(
      margin: EdgeInsets.all(dimens10),
      decoration: BoxDecoration(
          color: AppColors.COLOR_F9F9F9,
          borderRadius: BorderRadius.circular(dimens20)),
      padding: EdgeInsets.all(dimens30),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(attribute.attribute!,
                style: FMTextStyle.color_333333_size_42),
          ),
          Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  attribute.value!,
                  style: FMTextStyle.color_999999_size_42,
                ),
              )),
        ],
      ),
    );
  }

  ///商品描述信息
  _goodDes() {
    return Container(
      margin: EdgeInsets.only(left: dimens30, top: dimens30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: dimens20),
            child: Text(_model.goodDetailModel!.info!.name ?? "",
                style: FMTextStyle.color_333333_size_42_bold),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: dimens20),
            child: Text(_model.goodDetailModel!.info!.brief ?? "",
                style: FMTextStyle.color_999999_size_36),
          ),
          Row(
            children: <Widget>[
              Text(
                  "${AppStrings.ORIGINAL_PRICE}：${_model.goodDetailModel?.info?.counterPrice}",
                  style: FMTextStyle.color_999999_size_36_lineThrough),
              Padding(
                padding: EdgeInsets.only(left: dimens20, bottom: dimens10),
                child: Text(
                    "${AppStrings.CURRENT_PRICE}：${_model.goodDetailModel?.info?.retailPrice}",
                    style: FMTextStyle.color_ff5722_size_42),
              )
            ],
          ),
        ],
      ),
    );
  }

  _addCart(){
    SharedPreferencesUtil.instance.getString(AppStrings.TOKEN)
        .then((value) {
      if (value != null) {
        _cartViewModel
            .addCart(_model.goodDetailModel!.info!.id!,
            _model.specificationId, _number)
            .then((response) {
          if (response) {
            Navigator.of(context).pop(); //隐藏弹出框
          }
        });
      } else {
        NavigatorUtil.goLogin(context);
      }
    });
  }

}
