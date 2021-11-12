import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/ui/widgets/cached_image.dart';

///品牌制造商
class TabHomeBrand extends StatelessWidget {
  final List<BrandList> brandList;
  final String title;

  const TabHomeBrand({Key? key, required this.brandList, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);
    return Padding(
      padding: EdgeInsets.only(left: dimens30, right: dimens30),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
            alignment: Alignment.center,
            child: Text(
              title,
              style: FMTextStyle.color_333333_size_42_bold,
            ),
          ),
          ListView.builder(
              itemCount: brandList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _itemView(context, brandList[index]);
              }),
        ],
      ),
    );
  }

  Widget _itemView(BuildContext context, BrandList brand) {
    double dimens30 = ScreenUtil().setHeight(AppDimens.DIMENS_30);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => {
          //todo
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: CachedImageView(double.infinity,
                  ScreenUtil().setHeight(AppDimens.DIMENS_400), brand.picUrl!),
            ),
            Padding(
                padding: EdgeInsets.only(top: dimens30, left: dimens30),
                child: Text(brand.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FMTextStyle.color_333333_size_42)),
            Padding(
                padding: EdgeInsets.only(top: dimens30, left: dimens30),
                child: Text(brand.desc!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: FMTextStyle.color_999999_size_42)),
            Padding(
                padding: EdgeInsets.only(
                    top: dimens30, left: dimens30, bottom: dimens30),
                child: Text(AppStrings.DOLLAR + "${brand.floorPrice}",
                    style: FMTextStyle.color_ff5722_size_42)),
          ],
        ),
      ),
    );
  }
}
