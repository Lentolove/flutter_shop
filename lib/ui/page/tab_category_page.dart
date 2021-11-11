import 'package:flutter/material.dart';

///商品分类 tab 页面
class TabCategory extends StatefulWidget {
  const TabCategory({Key? key}) : super(key: key);

  @override
  _TabCategoryState createState() => _TabCategoryState();
}

class _TabCategoryState extends State<TabCategory> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    print("TabCategory  initState");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('商品分类'),
      ),
    );
  }
}
