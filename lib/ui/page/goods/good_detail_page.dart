import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_images.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/good_detail_model.dart';
import 'package:flutter_shop/ui/widgets/cached_image.dart';
import 'package:flutter_shop/ui/widgets/card_number.dart';
import 'package:flutter_shop/ui/widgets/divider_line.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/shared_preferences_util.dart';
import 'package:flutter_shop/utils/toast_util.dart';
import 'package:flutter_shop/view_model/cart_view_model.dart';
import 'package:flutter_shop/view_model/good_detail_view_model.dart';
import 'package:flutter_shop/view_model/user_view_model.dart';
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
              return _model.isCollection;
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
                    _collection();
                  },
                  child: Icon(
                    Icons.star,
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
                  onPressed: () {
                    _openBottomSheet(context, _model.goodDetailModel!, 1);
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
                    onPressed: () {
                      _openBottomSheet(context, _model.goodDetailModel!, 2);
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

  ///打开底部弹窗
  _openBottomSheet(BuildContext context, GoodDetailModel model, int showType) {
    print("_openBottomSheet");
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            width: double.infinity,
            height: ScreenUtil().setHeight(AppDimens.DIMENS_850),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(
                      ScreenUtil().setWidth(AppDimens.DIMENS_30)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CachedImageView(
                          ScreenUtil().setWidth(AppDimens.DIMENS_180),
                          ScreenUtil().setWidth(AppDimens.DIMENS_180),
                          model.info!.gallery![0]),
                      Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil()
                                  .setWidth(AppDimens.DIMENS_20))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              AppStrings.PRICE +
                                  "：" +
                                  "${model.info?.retailPrice}",
                              style: FMTextStyle.color_333333_size_42),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil()
                                    .setHeight(AppDimens.DIMENS_20)),
                          ),
                          Text(
                              AppStrings.ALREAD_SELECTED +
                                  model.productList![0].specifications![0],
                              style: FMTextStyle.color_333333_size_42),
                        ],
                      ),
                      Expanded(
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Image.asset(
                                  AppImages.CLOSE,
                                  width: ScreenUtil()
                                      .setWidth(AppDimens.DIMENS_60),
                                  height: ScreenUtil()
                                      .setWidth(AppDimens.DIMENS_60),
                                ),
                              ))),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
                  child: Text(AppStrings.SPECIFICATIONS,
                      style: FMTextStyle.color_333333_size_42),
                ),
                ChangeNotifierProvider.value(
                  value: _model,
                  child: Selector<GoodDetailViewModel, int>(
                      builder: (context, data, chile) {
                        return Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
                          child: Wrap(
                              spacing: ScreenUtil().setWidth(AppDimens.DIMENS_20),
                              children: _specificationsWidget(
                                  _model.goodDetailModel!.specificationList,
                                  data)),
                        );
                      }, selector: (context, model) {
                    return model.specificationId!;
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(AppDimens.DIMENS_20)),
                ),
                Container(
                    margin: EdgeInsets.all(
                        ScreenUtil().setWidth(AppDimens.DIMENS_30)),
                    child: Row(
                      children: [
                        Text(AppStrings.NUMBER,
                            style: FMTextStyle.color_333333_size_42),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(
                                ScreenUtil().setWidth(AppDimens.DIMENS_30)),
                            alignment: Alignment.centerRight,
                            child: CartNumberView(
                              number: 1,
                              callback: (value) {
                                setState(() {
                                  _number = value;
                                });
                                print(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
                /*显示立即购买或加入购物车*/
                Container(
                  margin: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(AppDimens.DIMENS_30),
                      left: ScreenUtil().setWidth(AppDimens.DIMENS_30),
                      right: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
                  child: SizedBox(
                    height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
                    width: double.infinity,
                    child: RaisedButton(
                      color: showType == 1
                          ? AppColors.COLOR_FF5722
                          : AppColors.COLOR_FF5722,
                      onPressed: () => showType == 1 ? _addCart() : _buy(),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppDimens.DIMENS_30))),
                      child: Text(
                          showType == 1
                              ? AppStrings.ADD_CART
                              : AppStrings.BUY,
                          style: FMTextStyle.color_ffffff_size_42),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  ///购买商品
  _buy() {
    SharedPreferencesUtil.instance.getString(AppStrings.TOKEN).then((value) {
      if (value != null) {
        _model
            .buy(_model.goodDetailModel!.info!.id!, _model.specificationId,
                _number)
            .then((response) {
          if (response > 0) {
            Navigator.of(context).pop(); //隐藏弹出框
            NavigatorUtil.goFillInOrder(context, response);
          } else {
            ToastUtil.showToast(_cartViewModel.errorMessage);
          }
        });
      } else {
        NavigatorUtil.goLogin(context);
      }
    });
  }

  //商品特性
  _specificationsWidget(
      List<GoodDetailSpecificationList>? specifications, int specificationId) {
    List<Widget> widgetList = [];
    if (specifications == null || specifications.isEmpty) return widgetList;
    for (var element in specifications) {
      widgetList.add(ChoiceChip(
        label: Text(element.name ?? "",
            style: specificationId == element.valueList![0].id
                ? FMTextStyle.color_ffffff_size_36
                : FMTextStyle.color_333333_size_42),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(ScreenUtil().setWidth(AppDimens.DIMENS_60))),
            side: BorderSide(
              color: specificationId == element.valueList![0].id
                  ? AppColors.COLOR_FF5722
                  : AppColors.COLOR_999999,
              width: ScreenUtil().setWidth(AppDimens.DIMENS_1),
            )),
        backgroundColor: AppColors.COLOR_FFFFFF,
        selectedColor: AppColors.COLOR_FF5722,
        selected: specificationId == element.valueList![0].id,
        onSelected: (value) => {
          if (value) {_model.setSpecificationId(element.valueList![0].id!)}
        },
      ));
    }
    return widgetList;
  }

  _addCart() {
    SharedPreferencesUtil.instance.getString(AppStrings.TOKEN).then((value) {
      if (value != null) {
        _cartViewModel
            .addCart(_model.goodDetailModel!.info!.id!, _model.specificationId,
                _number)
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

  _collection() {
    SharedPreferencesUtil.instance.getString(AppStrings.TOKEN).then((value) {
      if (value == null) {
        NavigatorUtil.goLogin(context);
      } else {
        _model.addOrDeleteCollect(widget.goodId).then((response) =>
            Provider.of<UserViewModel>(context, listen: false)
                .collectionDataChange());
      }
    });
  }
}
