import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/router/router_handlers.dart';
import 'package:flutter_shop/ui/page/404/not_found_page.dart';

class Routers {
  ///根页面
  static String root = "/";

  ///导引界面
  static String guide = "/guide";

  ///home主界面
  static String home = "/home";

  ///商品分类界面
  static String categoryGoods = "/categoryGoods";

  ///商品详情界面
  static String goodsDetail = "/goodsDetail";

  ///登录界面
  static String login = "/login";

  ///注册界面
  static String register = "/register";

  ///订单填写界面
  static String fillInOrder = "/fillInOrder";

  ///地址管理界面
  static String address = "/address";

  ///地址编辑界面
  static String editAddress = "/editAddress";

  ///优惠券界面
  static String coupon = "/coupon";

  ///搜索界面
  static String searchGoods = "/searchGoods";

  ///web界面
  static String webView = "/webView";

  static String brandDetail = "/brandDetail";
  static String projectSelectionDetail = "/projectSelectionDetail";
  static String collect = "/collect";
  static String aboutUs = "/aboutUs";
  static String feedBack = "/feedBack";
  static String footPrint = "/footPrint";
  static String submitSuccess = "/submitSuccess";
  static String homeCategoryGoods = "/homeCategoryGoods";
  static String orderPage = "/orderPage";
  static String orderDetailPage = "/orderDetailPage";

  ///为路由库配置未匹配到的时候跳转的界面
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler =
        Handler(handlerFunc: (context, Map<String, List<String>> parameters) {
      return const NotFoundPage();
    });
    
    ///配置路由界面节点
    router.define(root, handler: splashHandler);

    router.define(home, handler: homeHandler);

    router.define(categoryGoods, handler: categoryGoodsListHandler);

    router.define(goodsDetail, handler: goodsDetailsHandler);

    router.define(register, handler: registerHandler);

    router.define(fillInOrder, handler: fillInOrderHandler);

    router.define(login, handler: loginHandler);


    router.define(address, handler: addressHandler);

    router.define(editAddress, handler: editAddressHandler);

    router.define(coupon, handler: couponHandler);

    // router.define(searchGoods, handler: searchGoodsHandler);

    // router.define(webView, handler: webViewHandler);

    // router.define(brandDetail, handler: brandDetailHandler);

    // router.define(projectSelectionDetail, handler: projectSelectionDetailHandler);

    router.define(collect, handler: collectHandler);

    // router.define(aboutUs, handler: aboutUsHandler);

    // router.define(feedBack, handler: feedBackHandler);

    router.define(footPrint, handler: footPrintHandler);

    // router.define(submitSuccess, handler: submitSuccessHandler);

    // router.define(homeCategoryGoods, handler: homeCategoryGoodsHandler);

    router.define(orderPage, handler: orderHandler);

    router.define(orderDetailPage, handler: orderDetailHandler);
  }
}
