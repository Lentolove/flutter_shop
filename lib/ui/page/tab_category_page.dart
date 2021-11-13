import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/ui/widgets/empty_data.dart';
import 'package:flutter_shop/utils/refresh_state_util.dart';
import 'package:flutter_shop/view_model/tab_category_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///商品分类 tab 页面
class TabCategory extends StatefulWidget {
  const TabCategory({Key? key}) : super(key: key);

  @override
  _TabCategoryState createState() => _TabCategoryState();
}

class _TabCategoryState extends State<TabCategory>
    with SingleTickerProviderStateMixin {
  final TabCategoryViewModel _model = TabCategoryViewModel();

  final RefreshController _refreshController = RefreshController();

  double dimens10 = ScreenUtil().setHeight(AppDimens.DIMENS_10);
  double dimens3 = ScreenUtil().setHeight(AppDimens.DIMENS_3);
  double dimens30 = ScreenUtil().setHeight(AppDimens.DIMENS_30);
  double dimens300 = ScreenUtil().setHeight(AppDimens.DIMENS_300);
  double dimens160 = ScreenUtil().setHeight(AppDimens.DIMENS_160);

  @override
  void initState() {
    super.initState();
    print("TabCategory  initState");
    _model.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TabCategoryViewModel>(
        create: (_) => _model,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.CATEGORY),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: AppColors.COLOR_FFFFFF,
                ),
                onPressed: () {
                  //todo
                },
              )
            ],
          ),
          body:
              Consumer<TabCategoryViewModel>(builder: (context, model, child) {
            RefreshStateUtil.getInstance()
                .stopRefreshOrLoadMore(_refreshController);
            return RefreshConfiguration(
              child: SmartRefresher(
                  enablePullUp: false,
                  header: const WaterDropMaterialHeader(
                    backgroundColor: AppColors.COLOR_FF5722,
                  ),
                  controller: _refreshController,
                  onRefresh: () => _model.onRefresh(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        //左侧导航栏
                        flex: 2,
                        child: _parentCategoryWidget(),
                      ),
                      Expanded(
                          flex: 8,
                          child: _model.childList.isEmpty
                              ? const EmptyDataView()
                              : _childCategoryWidget())
                    ],
                  )),
            );
          }),
        ));
  }

  ///父目录样式
  Widget _parentCategoryWidget() {
    return Selector<TabCategoryViewModel, TabCategoryViewModel>(
        shouldRebuild: (previous, next) => previous.parentShouldBuild,
        selector: (context, provider) => provider,
        builder: (context, provider, child) {
          provider.parentRebuild();
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: provider.parentList.length,
            itemBuilder: (BuildContext context, int index) {
              return Selector<TabCategoryViewModel, int>(
                selector: (context, provider) {
                  return provider.selectIndex;
                },
                builder: (context, data, child) {
                  return _getFirstLevelView(
                      provider.parentList[index], index, data);
                },
              );
            },
          );
        });
  }

  ///左侧列表
  Widget _getFirstLevelView(CategoryModel model, int index, int selectIndex) {
    return InkWell(
      onTap: () {
        _itemParentClick(index);
      },
      child: Container(
        color: AppColors.COLOR_FFFFFF,
        width: ScreenUtil().setWidth(AppDimens.DIMENS_200),
        height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
        alignment: Alignment.center,
        child: Row(
          children: [
            Offstage(
                offstage: selectIndex != index,
                child: Container(
                  margin: EdgeInsets.only(top: dimens30, bottom: dimens30),
                  color: AppColors.COLOR_FF5722,
                  width: dimens3,
                )),
            Container(
              margin: EdgeInsets.only(left: dimens30),
              height: ScreenUtil().setHeight(AppDimens.DIMENS_80),
              alignment: Alignment.center,
              child: Text(
                model.name!,
                style: selectIndex == index
                    ? FMTextStyle.color_ff5722_size_42
                    : FMTextStyle.color_333333_size_42,
              ),
            )
          ],
        ),
      ),
    );
  }

  ///点击左侧的一级列表
  _itemParentClick(int index) {
    _model.setParentCategorySelect(index);
  }

  ///二级分类
  Widget _childCategoryWidget() {
    return Selector<TabCategoryViewModel, List<CategoryModel>>(selector:
        (BuildContext context, TabCategoryViewModel tabCategoryViewModel) {
      return _model.childList;
    }, builder:
        (BuildContext context, List<CategoryModel> data, Widget? child) {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(dimens30),
                child: SizedBox(
                  height: ScreenUtil().setHeight(AppDimens.DIMENS_300),
                  child: Image.network(
                    _model.categoryPicture ?? AppStrings.DEFAULT_URL,
                    fit: BoxFit.fill,
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: dimens30, bottom: dimens30),
              child: Text(_model.categoryName ?? "",
                  style: FMTextStyle.color_333333_size_42),
            ),
            GridView.builder(
                padding: EdgeInsets.all(dimens10),
                shrinkWrap: true,

                ///注意，如果外层也是可以滚动的ScrollView，一定要禁止子view滑动
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _model.childList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: dimens10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return _getChildItemView(_model.childList[index]);
                })
          ],
        ),
      );
    });
  }

  ///每个分类条目
  Widget _getChildItemView(CategoryModel model) {
    return GestureDetector(
      onTap: () {
        //todo
      },
      child: Card(
        child: Container(
          alignment: Alignment.center,
          width: dimens300,
          height: dimens300,
          child: Column(
            children: [
              Image.network(
                model.picUrl!,
                fit: BoxFit.fill,
                width: dimens160,
                height: dimens160,
              ),
              Padding(
                padding: EdgeInsets.only(top: dimens10, bottom: dimens10),
                child: Text(
                  model.name!,
                  style: FMTextStyle.color_333333_size_42,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
