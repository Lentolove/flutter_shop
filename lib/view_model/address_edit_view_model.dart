import 'package:flutter_shop/base/base_view_model.dart';
import 'package:flutter_shop/base/page_state.dart';
import 'package:flutter_shop/constant/app_parameters.dart';
import 'package:flutter_shop/model/address_model.dart';
import 'package:flutter_shop/repository/mine_repository.dart';
import 'package:flutter_shop/utils/toast_util.dart';

///地址操作
class AddressEditViewModel extends BaseViewModel {
  final MineRepository _mineRepository = MineRepository();

  AddressItem? _addressItem;

  String _addressArea = "";

  bool _isDefault = false;

  String? _name;

  String? _phone;

  String? _addressDetail;

  String? _areaId;

  String? _provinceName;

  String? _cityName;

  String? _countryName;

  int? _id;

  AddressItem? get addressModel => _addressItem;

  String get addressArea => _addressArea;

  bool get isDefault => _isDefault;

  String? get name => _name;

  String? get phone => _phone;

  String? get addressDetail => _addressDetail;

  String? get areaId => _areaId;

  String? get provinceName => _provinceName;

  String? get cityName => _cityName;

  String? get countryName => _countryName;

  int? get id => _id;

  //设置为默认
  setDefault(bool value, String name, String phone, String addressDetail) {
    _isDefault = value;
    _name = name;
    _phone = phone;
    _addressDetail = addressDetail;
    notifyListeners();
  }

  setAddressArea(String areaId, String provinceName, String cityName,
      String countryName, String name, String phone, String addressDetail) {
    _addressArea = provinceName + cityName + countryName;
    _areaId = areaId;
    _provinceName = provinceName;
    _cityName = cityName;
    _countryName = countryName;
    _name = name;
    _phone = phone;
    _addressDetail = addressDetail;
    notifyListeners();
  }

  //查询地址详情
  queryAddressDetail(var addressId) {
    if (addressId == null || addressId == 0) {
      pageState = PageState.hasData;
      _addressItem = AddressItem();
      notifyListeners();
      return;
    }
    var parameters = {AppParameters.ID: addressId.toString()};
    _mineRepository.queryAddressDetail(parameters).then((response) {
      if (response.isSuccess) {
        pageState = PageState.hasData;
        _addressItem = response.data;
        _isDefault = _addressItem?.isDefault ?? false;
        _addressArea =
            "${_addressItem?.province}${_addressItem?.city}${_addressItem?.county}";
        _name = _addressItem?.name;
        _phone = _addressItem?.tel;
        _addressDetail = _addressItem?.addressDetail;

        _areaId = _addressItem?.areaCode;
        _provinceName = _addressItem?.province;
        _cityName = _addressItem?.city;
        _countryName = _addressItem?.county;
        _id = _addressItem?.id;
        notifyListeners();
      } else {
        errorNotify(response.message);
      }
    });
  }

  ///存储地址
  Future<bool> saveAddress(
      String addressDetail,
      String areaCode,
      String city,
      String county,
      String id,
      bool isDefault,
      String name,
      String province,
      String tel) async {
    var parameters = {
      AppParameters.ADDRESS_DETAIL: addressDetail,
      AppParameters.AREA_CODE: areaCode,
      AppParameters.CITY: city,
      AppParameters.COUNTY: county,
      AppParameters.ID: id,
      AppParameters.IS_DEFAULT: isDefault,
      AppParameters.NAME: name,
      AppParameters.PROVINCE: province,
      AppParameters.TEL: tel
    };
    bool result = false;
    await _mineRepository.addAddress(parameters).then((response) {
      result = response.isSuccess;
      if (!result) {
        ToastUtil.showToast(response.message);
      }
    });
    return result;
  }

  ///删除地址
  Future<bool> deleteAddress(int id) async {
    var parameters = {AppParameters.ID: id};
    bool result = false;
    await _mineRepository.deleteAddress(parameters).then((response) {
      result = response.isSuccess;
    });
    return result;
  }
}
