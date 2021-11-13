import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/ui/widgets/good_widget.dart';
//floorGoodsList

///首页的商品，每个模块四个，2*2构成
class TabHomeGoods extends StatelessWidget {
  final List<GoodsModel> goodList;

  final String title;

  const TabHomeGoods({Key? key, required this.goodList, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
    return Container(
      padding: EdgeInsets.only(left: dimens30, right: dimens30),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: ScreenUtil().setWidth(AppDimens.DIMENS_120),
            alignment: Alignment.center,
            child: Text(title, style: FMTextStyle.color_333333_size_42_bold),
          ),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: goodList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.76,
                  crossAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return _getGridViewItem(context, goodList[index]);
              }),
        ],
      ),
    );
  }

  Widget _getGridViewItem(BuildContext context, GoodsModel good) {
    return GoodWidget(
        good: good,
        itemClick: (value) {
          //todo 跳转到详情页面
        });
  }
}
