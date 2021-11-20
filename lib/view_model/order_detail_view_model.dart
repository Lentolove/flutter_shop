import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/order_detail_model.dart';
import 'package:flutter_shop/repository/mine_repository.dart';

//订单详情界面
class OrderDetailViewModel extends BaseViewModel{

  final MineRepository _mineRepository = MineRepository();

  OrderDetailModel? _orderDetailModel;

  OrderDetailModel? get orderDetailModel => _orderDetailModel;

  //查询订单详情
  queryOrderDetail(int orderId) {
    var parameters = {AppParameters.ORDER_ID: orderId};
    _mineRepository.queryOrderDetail(parameters).then((response) {
      if (response.isSuccess) {
        _orderDetailModel = response.data;
        pageState =
        _orderDetailModel == null ? PageState.empty : PageState.hasData;
        notifyListeners();
      } else {
        errorNotify(response.message);
      }
    });
  }

}