import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/repository/home_repository.dart';

/// tabHome 首页数据 ViewModel
class TabHomeViewModel extends BaseViewModel {

  final HomeRepository _homeRepository = HomeRepository();

  HomeModel? homeModel;

  void loadTabHomeData() {
    _homeRepository.queryHomeData().then((value) {
      print("loadTabHomeData = ${value.data} ");
      if (value.isSuccess) {
        homeModel = value.data;
        pageState = homeModel == null ? PageState.empty : PageState.hasData;
        notifyListeners();
      }
    }, onError: (errorMessage) {
      pageState = PageState.error;
      notifyListeners();
    });
  }
}
