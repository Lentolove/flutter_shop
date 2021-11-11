import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';

///根据 PageStatus 状态显示不同页面
class PageStatusWidget {
  static Widget stateWidget(BaseViewModel model) {
    if (model.pageState == PageState.loading) {
      //正在加载页面
      return Center(child: Text("正在加载"));
    } else if (model.pageState == PageState.error) {
      //请求错误
      return Center(child: Text("请求错误"));
    } else {
      return Center(child: Text("无数据"));
    }
  }

  static Widget stateWidgetWithCallBack(
      BaseViewModel model, VoidCallback callback) {
    if (model.pageState == PageState.loading) {
      return Center(child: Text("正在加载"));
    } else if (model.pageState == PageState.error) {
      return Center(child: Text("请求错误"));
    } else {
      return Center(child: Text("无数据"));
    }
  }
}
