import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/ui/widgets/empty_data.dart';
import 'package:flutter_shop/ui/widgets/loading_dialog.dart';
import 'package:flutter_shop/ui/widgets/network_error.dart';

///根据 PageStatus 状态显示不同页面
class PageStatusWidget {
  static Widget stateWidget(BaseViewModel model) {
    if (model.pageState == PageState.loading) {
      //正在加载页面
      return const LoadingDialog(title: '正在加载');
    } else if (model.pageState == PageState.error) {
      //请求错误
      return const NetWorkErrorView();
    } else {
      return const EmptyDataView();
    }
  }

  static Widget stateWidgetWithCallBack(
      BaseViewModel model, VoidCallback callback) {
    if (model.pageState == PageState.loading) {
      return const LoadingDialog(title: "正在加载");
    } else if (model.pageState == PageState.error) {
      return NetWorkErrorView(callback: callback);
    } else {
      return const EmptyDataView();
    }
  }
}
