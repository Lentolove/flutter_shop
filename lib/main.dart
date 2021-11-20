import 'dart:developer';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/router/application.dart';
import 'package:flutter_shop/router/router_path.dart';
import 'package:flutter_shop/utils/shared_preferences_util.dart';
import 'package:flutter_shop/view_model/cart_view_model.dart';
import 'package:flutter_shop/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'constant/app_colors.dart';
import 'constant/app_string.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var _userViewModel = UserViewModel();
  await _userViewModel.refreshData();
  var _cartViewModel = CartViewModel();
  SharedPreferencesUtil.instance.getString(AppStrings.TOKEN).then((value) {
    if (value != null) {
      // _cartViewModel.queryCart();
    }
  });
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => _userViewModel),
    ChangeNotifierProvider(create: (_) => _cartViewModel),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  ///初始化路由插件
  MyApp({Key? key}) : super(key: key) {
    final router = FluroRouter();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: AppColors.themeColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: AppColors.COLOR_F8F8F8),
      navigatorKey: Application.navigatorKey,
      onGenerateRoute: Application.router!.generator,
      // home: HomePage(),
    );
  }
}
