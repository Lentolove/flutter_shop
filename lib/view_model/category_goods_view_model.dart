import 'dart:math';

import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/category_goods_model.dart';
import 'package:flutter_shop/model/category_title_model.dart';
import 'package:flutter_shop/model/home_model.dart';
import 'package:flutter_shop/repository/category_repository.dart';
import 'package:flutter_shop/repository/goods_repository.dart';

//分类下的商品类表
class CategoryGoodsViewModel extends BaseViewModel {
  final GoodsRepository _goodsRepository = GoodsRepository();

  final CategoryRepository _categoryRepository = CategoryRepository();

  //分类商品列表模型
  CategoryGoodsListModel? _categoryGoodsList;

  //获取打分类下的商品，比如: 居家 -》 ----
  CategoryTitleModel? _categoryTitleModel;

  final List<GoodsModel> _goodList = [];

  //是否可以加载更多
  bool _canLoadMore = false;

  CategoryGoodsListModel? get categoryGoodsList => _categoryGoodsList;

  CategoryTitleModel? get categoryTitleModel => _categoryTitleModel;

  List<GoodsModel> get goodList => _goodList;

  bool get canLoadMore => _canLoadMore;

  ///进行分页数据请求
  void queryCategoryList(int categoryId, int pageIndex, int limit) {
    var parameters = {
      AppParameters.CATEGORY_ID: categoryId,
      AppParameters.PAGE: pageIndex,
      AppParameters.LIMIT: limit
    };
    _goodsRepository.getCategoryGoodsList(parameters).then((response) {
      if (response.isSuccess && response.data != null) {
        _categoryGoodsList = response.data!;
        //进行分页处理
        if (pageIndex == 1) {
          //首次加载,将列表数据清空
          _goodList.clear();
        }
        //否则添加到列表中
        _goodList.addAll(response.data!.list!);
        pageState = _goodList.isEmpty ? PageState.empty : PageState.hasData;
        _canLoadMore = response.data!.total! > _goodList.length;
        //通知数据变更
        notifyListeners();
      } else {
        errorNotify(response.message);
      }
    });
  }

  ///获取分类商品列表
  void queryCategoryName(int categoryId) {
    var parameters = {
      AppParameters.ID: categoryId,
    };
    _categoryRepository.getCategoryTitle(parameters).then((response) {
      if (response.isSuccess && response.data != null) {
        _categoryTitleModel = response.data!;
        notifyListeners();
      } else {
        print(e);
        // ToastUtil.showToast(response.message);
      }
    });
  }
}
