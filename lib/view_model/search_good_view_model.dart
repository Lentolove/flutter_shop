import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/model/search_good_model.dart';
import 'package:flutter_shop/repository/goods_repository.dart';
import 'package:flutter_shop/utils/toast_util.dart';

//搜索界面
class SearchGoodViewModel extends BaseViewModel{

  final GoodsRepository _goodsRepository = GoodsRepository();

  SearchGoodsModel? _searchGoodsModel;

  final List<GoodsModel> _goodList = [];

  bool _publishTimeConditionArrowUp = false;

  bool _priceConditionArrowUp = false;

  bool _isLoadMore = false;

  SearchGoodsModel? get searchGoodsModel => _searchGoodsModel;

  List<GoodsModel> get goodList => _goodList;

  bool get publishTimeConditionArrowUp => _publishTimeConditionArrowUp;

  bool get priceConditionArrowUp => _priceConditionArrowUp;

  bool get isLoadMore => _isLoadMore;

  //按照发布时间升序排列
  setPublicTimeCondition(bool isUp) {
    _publishTimeConditionArrowUp = isUp;
    notifyListeners();
  }

  //按照价格排序
  setPriceCondition() {
    _priceConditionArrowUp = !_priceConditionArrowUp;
    print(_priceConditionArrowUp);
    notifyListeners();
  }

  //设置按照时间降序
  setPublishTimeCondition() {
    _publishTimeConditionArrowUp = !_publishTimeConditionArrowUp;
    notifyListeners();
  }

  Future<bool> searchGoods(String keyword, int pageIndex, int limit,
      String sortName, String orderType) async {
    var parameters = {
      AppParameters.KEYWORD: keyword,
      AppParameters.PAGE: pageIndex,
      AppParameters.LIMIT: limit,
      AppParameters.SORT: sortName,
      AppParameters.ORDER: orderType
    };
    await _goodsRepository.searchGoods(parameters).then((response) {
      if (response.isSuccess) {
        _searchGoodsModel = response.data;
        if (pageIndex == 1) {
          _goodList.clear();
        }
        _goodList.addAll(_searchGoodsModel!.xList ?? []);
        pageState = _goodList.isEmpty ? PageState.empty : PageState.hasData;
        _isLoadMore = _searchGoodsModel!.total! > _goodList.length;
        print("搜索到： ${_goodList.length}");
        notifyListeners();
      } else {
        if (pageIndex == 1) {
          pageState = PageState.error;
        }
        ToastUtil.showToast(response.message);
        notifyListeners();
      }
    });
    return true;
  }
}