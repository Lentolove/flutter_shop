import 'package:fluro/fluro.dart';
import 'dart:convert';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/ui/page/404/not_found_page.dart';
import 'package:flutter_shop/ui/page/goods/category_googs_page.dart';
import 'package:flutter_shop/ui/page/goods/fill_in_order_page.dart';
import 'package:flutter_shop/ui/page/goods/good_detail_page.dart';
import 'package:flutter_shop/ui/page/home_page.dart';
import 'package:flutter_shop/ui/page/login/login_page.dart';
import 'package:flutter_shop/ui/page/login/register_page.dart';
import 'package:flutter_shop/ui/page/main_page.dart';
import 'package:flutter_shop/ui/page/mine/address_editing_page.dart';
import 'package:flutter_shop/ui/page/mine/address_page.dart';
import 'package:flutter_shop/ui/page/mine/oder_detail_page.dart';
import 'package:flutter_shop/ui/page/mine/order_page.dart';

//引导页
var splashHandler =
    Handler(handlerFunc: (context, Map<String, List<String>> parameters) {
  return MainPage();
});

//首页
var homeHandler =
    Handler(handlerFunc: (context, Map<String, List<String>> parameters) {
  return HomePage();
});

//404页面
var notFindHandler =
    Handler(handlerFunc: (context, Map<String, List<String>> parameters) {
  return NotFoundPage();
});

// 分类页面的二级页面的跳转页面,分类商品列表页
var categoryGoodsListHandler = Handler(handlerFunc: (context, parameters) {
  var categoryName = jsonDecode(parameters[AppParameters.CATEGORY_NAME]!.first);
  var categoryId = int.parse(parameters[AppParameters.CATEGORY_ID]!.first);
  return CategoryGoodsPage(categoryName: categoryName, categoryId: categoryId);
});

//商品详情页面
var goodsDetailsHandler = Handler(handlerFunc: (context, parameters) {
  var goodId = int.parse(parameters[AppParameters.GOODS_ID]!.first);
  return GoodDetailPage(goodId: goodId);
});

//登录页面
var loginHandler = Handler(handlerFunc: (context, parameters) {
  return LoginPage();
});

//注册界面
var registerHandler = Handler(handlerFunc: (context, parameters) {
  return RegisterPage();
});

//填写订单界面
var fillInOrderHandler = Handler(handlerFunc: (context, parameters) {
  var cartId = int.parse(parameters[AppParameters.CART_ID]!.first);
  return FillInOrderPage(cartId: cartId);
});

//编辑地址界面
var editAddressHandler = Handler(handlerFunc: (context, parameters) {
  var addressId = int.parse(parameters["addressId"]!.first);
  return AddressEditingPage(addressId: addressId);
});

//地址列表界面
var addressHandler = Handler(handlerFunc: (context, parameters) {
  var isSelect = int.parse(parameters["isSelect"]!.first);
  return AddressPage(type: isSelect);
});

//订单列表界面
var orderHandler = Handler(handlerFunc: (context, parameters) {
  var initIndex =
      int.parse(parameters.isEmpty ? "0" : parameters["initIndex"]!.first);
  return OrderPage(initIndex: initIndex);
});

//订单详情
var orderDetailHandler = Handler(handlerFunc: (context, parameters) {
  var orderId = int.parse(parameters["orderId"]!.first);
  return OrderDetailPage(orderId: orderId);
});
