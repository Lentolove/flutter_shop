import 'package:flutter/material.dart';

/// home 首页
class TabHomePage extends StatefulWidget {
  const TabHomePage({Key? key}) : super(key: key);

  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    print("TabHomePage  initState");
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
