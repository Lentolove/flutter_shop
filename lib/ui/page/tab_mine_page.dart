import 'package:flutter/material.dart';

///我的 tab
class TabMinePage extends StatefulWidget {
  const TabMinePage({Key? key}) : super(key: key);

  @override
  _TabMinePageState createState() => _TabMinePageState();
}

class _TabMinePageState extends State<TabMinePage> with SingleTickerProviderStateMixin{


  @override
  void initState() {
    super.initState();
    print("TabMinePage  initState");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('我的'),
      ),
    );
  }
}
