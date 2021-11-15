import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/good_detail_model.dart';
import 'package:flutter_shop/repository/goods_repository.dart';

class GoodDetailViewModel extends BaseViewModel {
  final GoodsRepository _goodsRepository = GoodsRepository();

  GoodDetailModel? _goodDetailModel;

  var _specificationId;

  bool _isCollection = false;


  bool get isCollection => _isCollection;

  GoodDetailModel? get goodDetailModel => _goodDetailModel;

  get specificationId => _specificationId;

  ///获取商品详细信息
  void getGoodsDetail(int goodsId) async {
    var parameters = {AppParameters.ID: goodsId};
    await _goodsRepository.getGoodsDetailData(parameters).then((response) {
      if (response.isSuccess && response.data != null) {
        pageState = PageState.hasData;
        _goodDetailModel = response.data;
        _specificationId =
            _goodDetailModel?.specificationList?[0].valueList?[0].id;
        notifyListeners();
      } else {
        errorNotify(response.message);
      }
    });
    // queryAllCollection(goodsId);
  }

}
