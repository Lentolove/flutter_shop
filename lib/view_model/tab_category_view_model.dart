import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/repository/category_repository.dart';

///分类 Tab界面 ViewModel
class TabCategoryViewModel extends BaseViewModel {
  var _categoryId;

  var _categoryName;

  var _categoryPicture;

  var _selectIndex = 0;

  get categoryId => _categoryId;
  bool _parentShouldBuild = false;

  List<CategoryModel> _parentList = [];

  List<CategoryModel> _childList = [];

  //做一下数据缓存
  final Map<int, List<CategoryModel>> _cache = {};

  final CategoryRepository _repository = CategoryRepository();

  ///获取一级分类数据
  void getParentCategory() {
    _repository.getCategoryData().then((response) {
      if (response.isSuccess && response.data != null) {
        _parentList = response.data!.categories;
        if (_parentList.isNotEmpty) {
          _categoryId = _parentList[0].id;
          _categoryName = _parentList[0].name;
          _categoryPicture = _parentList[0].picUrl;
          _parentShouldBuild = true;
          getSecondCategory(_categoryId);
        } else {
          pageState = PageState.empty;
        }
      }else{
        errorNotify(response.message);
      }
    });
  }

  ///获取二级分类数据
  void getSecondCategory(var categoryId) {
    List<CategoryModel>? cacheList = _cache[categoryId];
    if (cacheList == null) {
      var parameters = {AppParameters.ID: categoryId};
      _repository.getSubCategoryData(parameters).then((response) {
        if (response.isSuccess && response.data != null) {
          _childList = response.data!.categories;
          _cache[categoryId] = _childList;
          notifyListeners();
        } else {
          errorNotify(response.message);
          notifyListeners();
        }
      });
    } else {
      _childList = cacheList;
      notifyListeners();
    }
  }

  void setParentCategorySelect(int index) {
    _selectIndex = index;
    _categoryPicture = _parentList[index].picUrl;
    _categoryName = _parentList[index].name;
    getSecondCategory(_parentList[index].id);
  }

  ///刷新数据
  void onRefresh() {
    print('onRefresh ....');
    _selectIndex = 0;
    _cache.clear();
    getParentCategory();
  }

  ///parent 数据是否请求成功
  parentRebuild() {
    _parentShouldBuild = false;
  }

  get categoryName => _categoryName;

  get categoryPicture => _categoryPicture;

  get selectIndex => _selectIndex;

  get parentShouldBuild => _parentShouldBuild;

  List<CategoryModel> get parentList => _parentList;

  List<CategoryModel> get childList => _childList;

  get repository => _repository;
}
