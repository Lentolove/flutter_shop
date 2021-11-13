import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/ui/page/goods/home_category_goods_page.dart';
import 'package:flutter_shop/ui/widgets/cached_image.dart';

///TabHome 商品类别
class TabHomeGoodsCategory extends StatelessWidget {
  final List<Channel> homeChannel;

  const TabHomeGoodsCategory({Key? key,required this.homeChannel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = ScreenUtil().setHeight(AppDimens.DIMENS_30);
    return Container(
      padding: EdgeInsets.only(top: height, bottom: height),
      color: AppColors.COLOR_FFFFFF,
      child: GridView.builder(
        //定义一个网格布局
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //在横轴上创建具有固定数量图块的网格布局
            //每个子项的横轴与主轴范围的占比
            childAspectRatio: 0.9,
            // 横轴上的子节点数
            crossAxisCount: 5,
            //每个widget之间的间距
            mainAxisSpacing: height,
            crossAxisSpacing: height),
        itemBuilder: (BuildContext context, int index) {
          return _getGridItem(context, homeChannel[index]);
        },
        physics: const NeverScrollableScrollPhysics(),
        //禁止滚动
        shrinkWrap: true,
        itemCount: homeChannel.length,
      ),
    );
  }

  ///每一个条目，上图下文字类型
  Widget _getGridItem(BuildContext context, Channel channel) {
    double width = ScreenUtil().setWidth(AppDimens.DIMENS_120);
    double paddingHeight = ScreenUtil().setWidth(AppDimens.DIMENS_10);
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
            return HomeCategoryGoodsPage(title: channel.name!,id: channel.id!);
          }));
        },
        child: Column(
          children: [
            CachedImageView(width, width, channel.iconUrl!),
            Padding(
              padding: EdgeInsets.only(top: paddingHeight),
            ),
            Text(
              channel.name!,
              style: FMTextStyle.color_333333_size_42,
            )
          ],
        ),
      ),
    );
  }
}
