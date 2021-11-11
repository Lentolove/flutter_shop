import 'package:flutter/material.dart';

///主页面 page
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{


  @override
  void initState() {
    super.initState();
    print("MainPage  initState");
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
