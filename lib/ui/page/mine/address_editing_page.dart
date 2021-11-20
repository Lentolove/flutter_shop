import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_colors.dart';
import 'package:flutter_shop/constant/app_dimens.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/constant/text_style.dart';
import 'package:flutter_shop/ui/widgets/divider_line.dart';
import 'package:flutter_shop/ui/widgets/page_status_widget.dart';
import 'package:flutter_shop/utils/toast_util.dart';
import 'package:flutter_shop/view_model/address_edit_view_model.dart';
import 'package:provider/provider.dart';

///地址编辑界面
class AddressEditingPage extends StatefulWidget {
  final int addressId;

  const AddressEditingPage({Key? key, this.addressId = -1}) : super(key: key);

  @override
  _AddressEditingPageState createState() => _AddressEditingPageState();
}

class _AddressEditingPageState extends State<AddressEditingPage> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _addressDetailController = TextEditingController();

  final AddressEditViewModel _editViewModel = AddressEditViewModel();

  var _addressId;

  double dimens30 = ScreenUtil().setWidth(AppDimens.DIMENS_30);

  @override
  void initState() {
    super.initState();
    _addressId = widget.addressId;
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.ADDRESS_EDIT_TITLE),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<AddressEditViewModel>(
        create: (_) => _editViewModel,
        child: Consumer<AddressEditViewModel>(
          builder: (context, model, chile) {
            _initController(model);
            return _showWidget(model);
          },
        ),
      ),
    );
  }

  _showWidget(AddressEditViewModel model) {
    if (model.pageState == PageState.hasData) {
      return _contentView(model);
    } else {
     return PageStatusWidget.stateWidgetWithCallBack(model, () {
        _onRefresh();
      });
    }
  }

  //编辑地址视图
  _contentView(AddressEditViewModel model) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(dimens30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _nameWidget(),
                          const DividerLineView(),
                          _phoneWidget(),
                          const DividerLineView(),
                          _addressAreaSelectWidget(model),
                          const DividerLineView(),
                          _addressDetailWidget(),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: dimens30)),
                    _setDefaultWidget(model),
                    _saveWidget(model),
                    _deleteWidget(model)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //姓名视图
  _nameWidget() {
    return Container(
      padding: EdgeInsets.only(left: dimens30, right: dimens30),
      alignment: Alignment.center,
      width: double.infinity,
      height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: 0,
              child: Text(
                AppStrings.NAME,
                style: FMTextStyle.color_333333_size_42,
              )),
          Positioned(
              left: ScreenUtil().setWidth(AppDimens.DIMENS_200),
              child: SizedBox(
                width: ScreenUtil().setWidth(AppDimens.DIMENS_800),
                child: TextField(
                    maxLines: 1,
                    cursorColor: AppColors.COLOR_FF5722,
                    controller: _nameController,
                    style: FMTextStyle.color_333333_size_42,
                    decoration: InputDecoration(
                      hintText: AppStrings.ADDRESS_PLEASE_INPUT_NAME,
                      hintStyle: FMTextStyle.color_999999_size_42,
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                    )),
              ))
        ],
      ),
    );
  }

  //电话视图
  _phoneWidget() {
    return Container(
      padding: EdgeInsets.only(left: dimens30, right: dimens30),
      alignment: Alignment.center,
      width: double.infinity,
      height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: 0,
              child: Text(
                AppStrings.PHONE,
                style: FMTextStyle.color_333333_size_42,
              )),
          Positioned(
              left: ScreenUtil().setWidth(AppDimens.DIMENS_200),
              child: SizedBox(
                width: ScreenUtil().setWidth(AppDimens.DIMENS_800),
                child: TextField(
                    maxLines: 1,
                    cursorColor: AppColors.COLOR_FF5722,
                    controller: _phoneController,
                    style: FMTextStyle.color_333333_size_42,
                    decoration: InputDecoration(
                      hintText: AppStrings.ADDRESS_PLEASE_INPUT_PHONE,
                      hintStyle: FMTextStyle.color_999999_size_42,
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                    )),
              ))
        ],
      ),
    );
  }

  //地区选择视图
  _addressAreaSelectWidget(AddressEditViewModel model) {
    return Container(
      padding: EdgeInsets.only(left: dimens30, right: dimens30),
      alignment: Alignment.center,
      width: double.infinity,
      height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: 0,
              child: Text(
                AppStrings.ADDRESS_AREA,
                style: FMTextStyle.color_333333_size_42,
              )),
          Positioned(
            left: ScreenUtil().setWidth(AppDimens.DIMENS_200),
            child: SizedBox(
                width: ScreenUtil().setWidth(AppDimens.DIMENS_800),
                child: InkWell(
                    onTap: () => _show(context, model),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: ScreenUtil().setHeight(AppDimens.DIMENS_160),
                      child: Text(
                        model.addressArea.isEmpty
                            ? AppStrings.ADDRESS_PLEASE_SELECT_CITY
                            : model.addressArea,
                        style: model.addressArea.isEmpty
                            ? FMTextStyle.color_999999_size_42
                            : FMTextStyle.color_333333_size_42,
                      ),
                    ))),
          )
        ],
      ),
    );
  }

  //弹出地区选择器视图，引用城市选择插件:https://pub.dev/packages/city_pickers
  _show(BuildContext context, AddressEditViewModel model) async {
    Result? temp = await CityPickers.showCityPicker(
        context: context,
        itemExtent: ScreenUtil().setHeight(AppDimens.DIMENS_120),
        height: ScreenUtil().setHeight(AppDimens.DIMENS_600),
        itemBuilder: (item, list, index) {
          return Center(
            child: Text(item,
                maxLines: 1, style: FMTextStyle.color_333333_size_42),
          );
        });
    if (temp == null) return;
    //设置选择的结果
    _editViewModel.setAddressArea(
        temp.areaId!,
        temp.provinceName!,
        temp.cityName!,
        temp.areaName!,
        _nameController.text.trim(),
        _phoneController.text.trim(),
        _addressDetailController.text.trim());
  }

  //详细地址视图
  _addressDetailWidget() {
    return Container(
      padding: EdgeInsets.only(left: dimens30, right: dimens30),
      alignment: Alignment.center,
      width: double.infinity,
      height: ScreenUtil().setHeight(AppDimens.DIMENS_200),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: 0,
              child: Text(
                AppStrings.ADDRESS_DETAIL,
                style: FMTextStyle.color_333333_size_42,
              )),
          Positioned(
            left: ScreenUtil().setWidth(AppDimens.DIMENS_200),
            child: SizedBox(
                width: ScreenUtil().setWidth(AppDimens.DIMENS_800),
                height: ScreenUtil().setHeight(AppDimens.DIMENS_200),
                child: TextField(
                    maxLines: 3,
                    controller: _addressDetailController,
                    style: FMTextStyle.color_333333_size_42,
                    cursorColor: AppColors.COLOR_FF5722,
                    decoration: InputDecoration(
                      hintText: AppStrings.ADDRESS_PLEASE_INPUT_DETAIL,
                      hintStyle: FMTextStyle.color_999999_size_42,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ))),
          )
        ],
      ),
    );
  }

  //设为默认地址视图
  _setDefaultWidget(AddressEditViewModel model) {
    return Card(
      elevation: 0,
      child: Container(
        padding: EdgeInsets.only(left: dimens30, right: dimens30),
        alignment: Alignment.center,
        width: double.infinity,
        height: ScreenUtil().setHeight(AppDimens.DIMENS_150),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                left: 0,
                child: Text(
                  AppStrings.ADDRESS_SET_DEFAULT,
                  style: FMTextStyle.color_333333_size_42,
                )),
            Positioned(
              right: ScreenUtil().setWidth(AppDimens.DIMENS_20),
              child: Container(
                alignment: Alignment.centerRight,
                child: CupertinoSwitch(
                    value: model.isDefault,
                    activeColor: AppColors.COLOR_FF5722,
                    onChanged: (value) {
                      print(value);
                      model.setDefault(value, _nameController.text,
                          _phoneController.text, _addressDetailController.text);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  _saveWidget(AddressEditViewModel model) {
    return Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(AppDimens.DIMENS_80),
            left: dimens30,
            right: dimens30),
        width: double.infinity,
        child: RaisedButton(
          onPressed: () => _submit(model),
          color: AppColors.COLOR_FF5722,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimens.DIMENS_60),
            ),
          ),
          child: Text(
            AppStrings.SAVE,
            style: FMTextStyle.color_ffffff_size_42,
          ),
        ));
  }

  _deleteWidget(AddressEditViewModel model) {
    return Visibility(
      visible: !(_addressId == null || _addressId == -1),
      child: Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(AppDimens.DIMENS_40),
            left: ScreenUtil().setWidth(AppDimens.DIMENS_30),
            right: ScreenUtil().setWidth(AppDimens.DIMENS_30)),
        width: double.infinity,
        child: RawMaterialButton(
          onPressed: () => _delete(context, model),
          child: Text(
            AppStrings.ADDRESS_DELETE,
            style: FMTextStyle.color_333333_size_42,
          ),
          elevation: 0,
          highlightElevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(AppDimens.DIMENS_60),
              ),
              side: BorderSide(
                  color: AppColors.COLOR_999999,
                  width: ScreenUtil().setWidth(AppDimens.DIMENS_1))),
          fillColor: AppColors.COLOR_FFFFFF,
        ),
      ),
    );
  }

  //保存地址
  _submit(AddressEditViewModel model) {
    if (!_judgeAddressBody()) return;
    model
        .saveAddress(
            _addressDetailController.text,
            model.areaId!,
            model.cityName!,
            model.countryName!,
            _addressId.toString(),
            model.isDefault,
            _nameController.text,
            model.provinceName!,
            _phoneController.text)
        .then((value) {
      if (value) {
        Navigator.pop(context);
      }
    });
  }

  //删除地址dialog
  _delete(BuildContext context, AddressEditViewModel model) {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppStrings.TIPS,
              style: FMTextStyle.color_333333_size_48,
            ),
            content: Text(
              AppStrings.ADDRESS_DELETE_TIPS,
              style: FMTextStyle.color_333333_size_42,
            ),
            actions: <Widget>[
              FlatButton(
                color: AppColors.COLOR_FFFFFF,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppStrings.CANCEL,
                  style: FMTextStyle.color_ff5722_size_42,
                ),
              ),
              FlatButton(
                color: AppColors.COLOR_FFFFFF,
                onPressed: () {
                  Navigator.pop(context);
                  _deleteAddress(model);
                },
                child: Text(
                  AppStrings.CONFIRM,
                  style: FMTextStyle.color_333333_size_42,
                ),
              ),
            ],
          );
        });
  }

  //删除地址
  _deleteAddress(AddressEditViewModel model) {
    model.deleteAddress(_addressId).then((response) {
      if (response) {
        ToastUtil.showToast(AppStrings.ADDRESS_DELETE_SUCCESS);
        Navigator.pop(context);
      } else {
        ToastUtil.showToast(model.errorMessage);
      }
    });
  }

  //初始化地址数据
  _initController(AddressEditViewModel model) {
    _nameController = TextEditingController(
      text: model.name ?? "",
    );
    _phoneController = TextEditingController(
      text: model.phone ?? "",
    );
    _addressDetailController = TextEditingController(
      text: model.addressDetail ?? "",
    );
  }

  //更新地址信息
  _onRefresh() {
    _editViewModel.queryAddressDetail(_addressId);
  }

  //判断信息是否有效
  bool _judgeAddressBody() {
    if (_nameController.text.toString().isEmpty) {
      ToastUtil.showToast(AppStrings.ADDRESS_PLEASE_INPUT_NAME);
      return false;
    }
    if (_phoneController.text.toString().isEmpty) {
      ToastUtil.showToast(AppStrings.ADDRESS_PLEASE_INPUT_PHONE);
      return false;
    }
    if (_editViewModel.addressArea.isEmpty) {
      ToastUtil.showToast(AppStrings.ADDRESS_PLEASE_SELECT_CITY);
      return false;
    }
    if (_addressDetailController.text.toString().isEmpty) {
      ToastUtil.showToast(AppStrings.ADDRESS_PLEASE_INPUT_DETAIL);
      return false;
    }
    if (_phoneController.text.toString().length != 11) {
      ToastUtil.showToast(AppStrings.ADDRESS_PLEASE_INPUT_CORRECT_PHONE);
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressDetailController.dispose();
    super.dispose();
  }
}
