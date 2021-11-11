import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/base/page_state.dart';

///定义baseViewModel基类进行页面状态通知
class BaseViewModel extends ChangeNotifier {
  //页面加载状态
  PageState pageState = PageState.loading;

  //是否销毁
  bool _isDispose = false;

  //错误信息
  var errorMessage;

  bool get isDispose => _isDispose;

  @override
  void notifyListeners() {
    print("view model notifyListeners");
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  errorNotify(String error) {
    pageState = PageState.error;
    errorMessage = error;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDispose = true;
    print("view model dispose");
    super.dispose();
  }
}
