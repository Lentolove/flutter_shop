import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/order_list_model.dart';
import 'package:flutter_shop/repository/mine_repository.dart';
import 'package:flutter_shop/utils/toast_util.dart';

class OrderViewModel extends BaseViewModel{

  final MineRepository _mineRepository = MineRepository();

  bool _canLoadMore = false;

  final List<OrderModel> _data = [];

  List<OrderModel> get data => _data;

  bool get canLoadMore => _canLoadMore;

  //查询订单列表
  queryOrder(int orderType, int pageIndex, int pageSize) {
    var parameters = {
      AppParameters.SHOW_TYPE: orderType,
      AppParameters.PAGE: pageIndex,
      AppParameters.LIMIT: pageSize
    };
    _mineRepository.queryOrder(parameters).then((response) {
      if (response.isSuccess) {
        OrderListModel model = response.data!;
        if (pageIndex == 1) {
          _data.clear();
        }
        _data.addAll(model.xList!);
        print(_data.length);
        _canLoadMore = model.total! > _data.length;
        pageState = _data.isEmpty ? PageState.empty : PageState.hasData;
        notifyListeners();
      } else {
        errorNotify(response.message);
      }
    });
  }

  //删除订单
  Future<bool> deleteOrder(int orderId) async {
    bool result = false;
    var parameters = {AppParameters.ORDER_ID: orderId};
    await _mineRepository.deleteOrder(parameters).then((response) {
      result = response.isSuccess;
      if (!result) {
        ToastUtil.showToast(response.message);
      }
    });
    return result;
  }

  //取消订单
  Future<bool> cancelOrder(int orderId) async {
    bool result = false;
    var parameters = {AppParameters.ORDER_ID: orderId};
    await _mineRepository.cancelOrder(parameters).then((response) {
      result = response.isSuccess;
      if (!result) {
        ToastUtil.showToast(response.message);
      }
    });
    return result;
  }
}