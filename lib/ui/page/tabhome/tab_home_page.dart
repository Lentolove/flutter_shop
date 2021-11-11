import 'package:flutter/material.dart';
import 'package:flutter_shop/view_model/tab_home_view_model.dart';

/// home 首页
class TabHomePage extends StatefulWidget {
  const TabHomePage({Key? key}) : super(key: key);

  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> with SingleTickerProviderStateMixin{

  TabHomeViewModel _model = TabHomeViewModel();


  @override
  void initState() {
    print("TabHomePage  initState");
    _model.loadTabHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('TabHome'),
      ),
    );
  }
}
