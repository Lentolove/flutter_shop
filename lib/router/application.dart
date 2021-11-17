import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

/// 路由插件 使用文档：https://pub.dev/packages/fluro
class Application {

  static FluroRouter? router;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}
