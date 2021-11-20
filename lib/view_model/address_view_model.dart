import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/model/address_model.dart';
import 'package:flutter_shop/repository/mine_repository.dart';

class AddressViewModel extends BaseViewModel {
  final MineRepository _mineRepository = MineRepository();

  final List<AddressItem> _address = [];


  List<AddressItem> get address => _address; //查询地址数据

  queryAddressData() {
    _mineRepository.getAddressList().then((response) {
      if (response.isSuccess && response.data != null) {
        _address.clear();
        if (response.data!.xList != null && response.data!.xList!.isNotEmpty) {
          _address.addAll(response.data!.xList!);
        }
        pageState = _address.isEmpty ? PageState.empty : PageState.hasData;
        notifyListeners();
      } else {
        errorNotify(response.message);
      }
    });
  }
}
