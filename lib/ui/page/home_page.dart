import 'package:flutter/material.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/event/tab_select_event.dart';
import 'package:flutter_shop/ui/page/tab_car_page.dart';
import 'package:flutter_shop/ui/page/tab_category_page.dart';
import 'package:flutter_shop/ui/page/tab_mine_page.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/ui/page/tabhome/tab_home_page.dart';
import 'package:flutter_shop/utils/navigator_util.dart';
import 'package:flutter_shop/utils/shared_preferences_util.dart';

///首页，管理四个页面的切换
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pageList = [];

  @override
  void initState() {
    print("HomePage  initState");
    super.initState();
    SharedPreferencesUtil.instance.setBool(AppStrings.IS_FIRST, false);
    tabSelectBus.on<TabSelectEvent>().listen((event) {
      setState(() {
        TabSelectEvent tabSelectEvent = event;
        _selectedIndex = tabSelectEvent.selectIndex;
      });
    });
    _pageList
      ..add(const TabHomePage())
      ..add(const TabCategory())
      ..add(const TabCarPage())
      ..add(const TabMinePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //IndexedStack 的使用：https://juejin.cn/post/6973534234233274404
      body: IndexedStack(
        index: _selectedIndex,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _bottomNavigationBarItem(Icons.home, AppStrings.HOME),
          _bottomNavigationBarItem(Icons.category, AppStrings.CATEGORY),
          _bottomNavigationBarItem(Icons.shopping_cart, AppStrings.SHOP_CAR),
          _bottomNavigationBarItem(Icons.person, AppStrings.MINE),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.COLOR_FF5722,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  _bottomNavigationBarItem(IconData icon, String title) {
    return BottomNavigationBarItem(icon: Icon(icon), label: title);
  }

  void _onItemTapped(int index) {
    if (index == 2 || index == 3) {
      //todo 对购物车页面和我的页面登录验证拦截
      //检查本地是否保存了token，如果没有跳转到登录界面
      SharedPreferencesUtil.instance.getString(AppStrings.TOKEN).then((value) {
        if (value == null) {
          NavigatorUtil.goLogin(context);
          return;
        }
      });
      _changeIndex(index);
    } else {
      //防止点击当前BottomNavigationBarItem rebuild
      _changeIndex(index);
    }
  }

  _changeIndex(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}
