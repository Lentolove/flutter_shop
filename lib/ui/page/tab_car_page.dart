import 'package:flutter/material.dart';

///购物车
class TabCarPage extends StatefulWidget {
  const TabCarPage({Key? key}) : super(key: key);

  @override
  _TabCarPageState createState() => _TabCarPageState();
}

class _TabCarPageState extends State<TabCarPage> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    print("TabCarPage  initState");

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('购物车'),
      ),
    );
  }
}
