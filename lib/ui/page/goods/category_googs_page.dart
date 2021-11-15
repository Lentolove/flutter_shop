import 'package:flutter/material.dart';
import 'package:flutter_shop/ui/page/goods/category_goods_widget.dart';

///分类页面的二级页面的跳转页面
class CategoryGoodsPage extends StatefulWidget {
  final String categoryName;
  final int categoryId;

  const CategoryGoodsPage(
      {Key? key, required this.categoryName, required this.categoryId})
      : super(key: key);

  @override
  _CategoryGoodsPageState createState() => _CategoryGoodsPageState();
}

class _CategoryGoodsPageState extends State<CategoryGoodsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.categoryName),
        ),
        body: CategoryGoodsWidget(categoryId: widget.categoryId));
  }
}
