///地址数据模型
class AddressModel {
  int? total;
  int? pages;
  int? limit;
  int? page;
  List<AddressItem>? xList;

  AddressModel({this.total, this.pages, this.limit, this.page, this.xList});

  AddressModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    limit = json['limit'];
    page = json['page'];
    if (json['list'] != null) {
      xList = [];
      for (var v in json['list']) {
        xList?.add(AddressItem.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['pages'] = pages;
    data['limit'] = limit;
    data['page'] = page;
    if (xList != null) {
      data['list'] = xList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressItem {
  String? addTime;
  String? city;
  String? county;
  String? updateTime;
  int? userId;
  String? areaCode;
  bool? isDefault;
  String? addressDetail;
  bool? deleted;
  String? province;
  String? name;
  String? tel;
  int? id;

  AddressItem(
      {this.addTime,
      this.city,
      this.county,
      this.updateTime,
      this.userId,
      this.areaCode,
      this.isDefault,
      this.addressDetail,
      this.deleted,
      this.province,
      this.name,
      this.tel,
      this.id});

  AddressItem.fromJson(Map<String, dynamic> json) {
    addTime = json['addTime'];
    city = json['city'];
    county = json['county'];
    updateTime = json['updateTime'];
    userId = json['userId'];
    areaCode = json['areaCode'];
    isDefault = json['isDefault'];
    addressDetail = json['addressDetail'];
    deleted = json['deleted'];
    province = json['province'];
    name = json['name'];
    tel = json['tel'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addTime'] = addTime;
    data['city'] = city;
    data['county'] = county;
    data['updateTime'] = updateTime;
    data['userId'] = userId;
    data['areaCode'] = areaCode;
    data['isDefault'] = isDefault;
    data['addressDetail'] = addressDetail;
    data['deleted'] = deleted;
    data['province'] = province;
    data['name'] = name;
    data['tel'] = tel;
    data['id'] = id;
    return data;
  }
}
