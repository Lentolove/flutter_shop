import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/ui/widgets/cached_image.dart';

///专题精选
class TabHomeTopic extends StatelessWidget {
  final String title;
  final List<TopicList> topicList;

  const TabHomeTopic({Key? key, required this.title, required this.topicList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
    return Container(
      padding: EdgeInsets.only(top: dimens30, bottom: dimens30),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(AppDimens.DIMENS_56),
                  color: AppColors.COLOR_333333,
                  fontWeight: FontWeight.w600),
            ),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(dimens30),
              itemCount: topicList.length,
              itemBuilder: (BuildContext context, int index) {
                return _itemView(context, topicList[index]);
              }),
        ],
      ),
    );
  }

  _itemView(BuildContext context, TopicList item) {
    double dimens20 = ScreenUtil().setHeight(AppDimens.DIMENS_20);
    return Card(
        child: InkWell(
            onTap: () {
              //todo
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedImageView(double.infinity,
                    ScreenUtil().setHeight(AppDimens.DIMENS_400), item.picUrl!),
                Padding(
                    padding: EdgeInsets.only(left: dimens20, top: dimens20),
                    child: Text(item.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FMTextStyle.color_333333_size_42)),
                Padding(
                    padding: EdgeInsets.only(left: dimens20, top: dimens20),
                    child: Text(item.subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FMTextStyle.color_999999_size_36)),
                Padding(
                    padding: EdgeInsets.only(
                        left: dimens20, top: dimens20, bottom: dimens20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_getPrice(item.price),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: FMTextStyle.color_ff5722_size_40),
                        Text('浏览量：${item.readCount}',
                            style: FMTextStyle.color_999999_size_36),
                      ],
                    ))
              ],
            )));
  }

  String _getPrice(double? price) {
    if (price == null || price <= 0) {
      return AppStrings.DOLLAR + '??';
    } else {
      return AppStrings.DOLLAR + price.toString();
    }
  }
}
