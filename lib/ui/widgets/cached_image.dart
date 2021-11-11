import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_images.dart';


///带缓存的Image
class CachedImageView extends StatelessWidget {
  final double width;
  final double height;
  final String url;

  const CachedImageView(this.width, this.height, this.url, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: CachedNetworkImage(
        imageUrl: url,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
        placeholder: (BuildContext context, String url) {
          return Container(
            color: AppColors.COLOR_F0F0F0,
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.DEFAULT_PICTURE,
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}
