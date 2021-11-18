import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/cart_model.dart';
import 'package:flutter_shop/repository/cart_repository.dart';
import 'package:flutter_shop/utils/toast_util.dart';

///购物车
class CartViewModel extends BaseViewModel {
  //购物车数据接口
  final CartRepository _repository = CartRepository();

  CartModel? _cartModel;

  bool _isAllCheck = false;

  bool _isShowBottomView = false;

  bool get isShowBottomView => _isShowBottomView;

  CartModel? get cartModel => _cartModel;

  bool get isAllCheck => _isAllCheck;

  ///添加到购物车
  Future<bool> addCart(int goodsId, int productId, int number) async {
    bool result = false;
    var parameters = {
      AppParameters.GOODS_ID: goodsId,
      AppParameters.PRODUCT_ID: productId,
      AppParameters.NUMBER: number
    };
    await _repository.addCart(parameters).then((response) {
      result = response.isSuccess;
      if (!result) {
        ToastUtil.showToast(response.message);
      } else {
        queryCart();
      }
    });
    return result;
  }

  //查询购物车
  queryCart() {
    _repository.queryCart().then((response) {
      if (response.isSuccess) {
        _cartModel = response.data;
        _isAllCheck = _checkedAll();
        pageState =
            _cartModel!.cartList!.isEmpty ? PageState.empty : PageState.hasData;
        _isShowBottomView = _cartModel!.cartList!.isNotEmpty;
        notifyListeners();
      } else {
        errorNotify(response.message);
        ToastUtil.showToast(response.message);
      }
    });
  }

  //查询所有商品是否已选择
  bool _checkedAll() {
    List<CartBean>? list = _cartModel!.cartList;
    if (list == null || list.isEmpty) return true;
    for (CartBean item in list) {
      if (!item.checked!) {
        return false;
      }
    }
    return true;
  }

  //删除购物车的商品
  Future<bool> deleteCartGoods(List productIds, int index) async {
    bool result = false;
    var parameters = {AppParameters.PRODUCT_IDS: productIds};
    await _repository.deleteCart(parameters).then((response) {
      if (response.isSuccess) {
        queryCart();
        result = true;
      } else {
        ToastUtil.showToast(response.message);
        result = false;
      }
    });
    notifyListeners();
    return result;
  }

  //更新购物车
  updateCartItem(int cartId, int number, int productId, int goodsId, int index) {
    var parameters = {
      AppParameters.PRODUCT_ID: productId,
      AppParameters.GOODS_ID: goodsId,
      AppParameters.NUMBER: number,
      AppParameters.ID: cartId,
    };
    _repository.updateCart(parameters).then((response) {
      if (response.isSuccess) {
        CartModel cartModel = CartModel.fromJson(_cartModel!.toJson());
        cartModel.cartList![index].number = number;
        _cartModel = cartModel;
        notifyListeners();
      } else {
        ToastUtil.showToast(response.message);
      }
    });
  }

  //下单
  checkCartItem(int productId, bool isCheck) {
    var parameters = {
      AppParameters.PRODUCT_IDS: [productId],
      AppParameters.IS_CHECKED: isCheck ? 1 : 0,
    };
    _repository.cartCheck(parameters).then((response) {
      if (response.isSuccess) {
        _cartModel = response.data;
        _isAllCheck = _checkedAll();
        notifyListeners();
      } else {
        ToastUtil.showToast(response.message);
        return false;
      }
    });
  }

  checkAllCartItem(List<int> productId, bool isCheck) {
    var parameters = {
      AppParameters.PRODUCT_IDS: productId,
      AppParameters.IS_CHECKED: isCheck ? 1 : 0,
    };
    _repository.cartCheck(parameters).then((response) {
      if (response.isSuccess) {
        _cartModel = response.data;
        _isAllCheck = _checkedAll();
        notifyListeners();
      } else {
        ToastUtil.showToast(response.message);
        return false;
      }
    });
  }

}
