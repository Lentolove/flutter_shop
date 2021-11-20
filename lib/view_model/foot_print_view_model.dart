import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/json_result.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/foot_print_model.dart';
import 'package:flutter_shop/repository/mine_repository.dart';

//足迹
class FootPrintViewModel extends BaseViewModel{

  final MineRepository _mineRepository = MineRepository();

  FootPrintModel? _footPrintModel;

  bool _canLoadMore=false;

  //是否显示选择按钮
  bool _isShowCheckBox = false;

  final List<FootPrintItem> _footList = [];

  FootPrintModel? get footPrintModel => _footPrintModel;

  bool get canLoadMore => _canLoadMore;

  bool get isShowCheckBox => _isShowCheckBox;

  List<FootPrintItem> get footList => _footList;

  setShowCheckBox(bool isShow) {
    _isShowCheckBox = isShow;
    notifyListeners();
  }

  queryFootPrint(int pageIndex, int limit) {
    var parameters = {AppParameters.PAGE: pageIndex, AppParameters.LIMIT: limit};
    _mineRepository.queryFootPrint(parameters).then((response) {
      if (response.isSuccess) {
        _footPrintModel = response.data;
        if (pageIndex == 1) {
          _footList.clear();
        } else {
          _footList.addAll(_footPrintModel!.xList ?? []);
        }
        _canLoadMore = _footList.length < _footPrintModel!.total!;
        pageState = _footList.isEmpty ? PageState.empty : PageState.hasData;
        notifyListeners();
      } else {
        errorNotify(response.message);
      }
    });
  }

  setCheck(int index, bool isCheck) {
    _footList[index].isCheck = isCheck;
    notifyListeners();
  }

  Future<bool> deleteFootPrint(List<dynamic> ids) async {
    bool isSuccess = true;
    for (int id in ids) {
      var parameters = {
        AppParameters.ID: id,
      };
      JsonResult result = await _mineRepository.deleteFootPrint(parameters);
      isSuccess = isSuccess && result.isSuccess;
    }
    return isSuccess;
  }

}