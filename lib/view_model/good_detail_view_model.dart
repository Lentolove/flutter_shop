import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/good_detail_model.dart';
import 'package:flutter_shop/repository/goods_repository.dart';
import 'package:flutter_shop/repository/mine_repository.dart';
import 'package:flutter_shop/utils/toast_util.dart';

class GoodDetailViewModel extends BaseViewModel {
  final GoodsRepository _goodsRepository = GoodsRepository();
  final MineRepository _mineRepository = MineRepository();

  GoodDetailModel? _goodDetailModel;

  var _specificationId;

  bool _isCollection = false;

  bool get isCollection => _isCollection;

  GoodDetailModel? get goodDetailModel => _goodDetailModel;

  get specificationId => _specificationId;

  //设置选中的规格
  setSpecificationId(int value) {
    _specificationId = value;
    notifyListeners();
  }

  ///获取商品详细信息
  void getGoodsDetail(int goodsId) async {
    var parameters = {AppParameters.ID: goodsId};
    await _goodsRepository.getGoodsDetailData(parameters).then((response) {
      if (response.isSuccess && response.data != null) {
        pageState = PageState.hasData;
        _goodDetailModel = response.data;
        _specificationId =
            _goodDetailModel?.specificationList?[0].valueList?[0].id;
        print(" userHasCollect = ${_goodDetailModel?.userHasCollect}");
        _isCollection = _goodDetailModel?.userHasCollect == 1 ? true : false;
        notifyListeners();
      } else {
        errorNotify(response.message);
      }
    });
    // queryAllCollection(goodsId);
  }

  ///添加收藏或者取消收藏
  Future<bool> addOrDeleteCollect(var goodsId) async {
    bool result = false;
    var parameters = {AppParameters.TYPE: 0, AppParameters.VALUE_ID: goodsId};
    await _mineRepository.addOrDeleteCollect(parameters).then((response) {
      result = response.isSuccess;
      if (response.isSuccess) {
        _isCollection = !isCollection;
        notifyListeners();
      } else {
        ToastUtil.showToast(response.message);
      }
    });
    return result;
  }

  ///理解购买
  Future<int> buy(int goodsId, int productId, int number) async {
    int result = 0;
    var parameters = {
      AppParameters.GOODS_ID: goodsId,
      AppParameters.PRODUCT_ID: productId,
      AppParameters.NUMBER: number,
      AppParameters.GROUPON_RULES_ID: 0,
      AppParameters.GROUPON_LINK_ID: 0
    };
    await _mineRepository.buy(parameters).then((response) {
      if (response.isSuccess) {
        result = response.data;
      }
    });
    return result;
  }


}
