import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/collection_model.dart';
import 'package:flutter_shop/repository/mine_repository.dart';
import 'package:flutter_shop/utils/toast_util.dart';

//收藏
class CollectViewModel extends BaseViewModel{

  final MineRepository _mineRepository = MineRepository();

  bool _canLoadMore = false;

  final List<CollectionItem> _collectionList = [];

  bool get canLoadMore => _canLoadMore;

  List<CollectionItem> get collectionList => _collectionList;

  //查询收藏列表
  queryData(int pageIndex, int limit) {
    var parameters = {
      AppParameters.TYPE: 0,
      AppParameters.PAGE: pageIndex,
      AppParameters.LIMIT: limit
    };
    _mineRepository.queryCollect(parameters).then((response) {
      if (response.isSuccess) {
        if (pageIndex == 1) {
          _collectionList.clear();
        }
        _collectionList.addAll(response.data?.xList ?? []);
        pageState = _collectionList.isEmpty ? PageState.empty : PageState.hasData;
        _canLoadMore = response.data!.total! > _collectionList.length;
        notifyListeners();
      } else {
        errorNotify(response.message);
      }
    });
  }

  //收藏和取消收藏
  Future addOrDeleteCollect(int index) {
    var parameters = {
      AppParameters.TYPE: 0,
      AppParameters.VALUE_ID: _collectionList[index].valueId
    };
    return _mineRepository.addOrDeleteCollect(parameters).then((response) {
      if (response.isSuccess) {
        _collectionList.removeAt(index);
        notifyListeners();
      } else {
        ToastUtil.showToast(response.message);
      }
    });
  }
}