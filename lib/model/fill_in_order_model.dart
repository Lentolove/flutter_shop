class FillInOrderModel {
  int? grouponRulesId;
  double? actualPrice;
  double? orderTotalPrice;
  int? cartId;
  int? couponId;
  double? goodsTotalPrice;
  int? addressId;
  int? grouponPrice;
  FillInOrderCheckedAddress? checkedAddress;
  var couponPrice;
  int? availableCouponLength;
  int? freightPrice;
  List<FillInOrderCheckedGoodList>? checkedGoodsList;

  FillInOrderModel(
      {this.grouponRulesId,
      this.actualPrice,
      this.orderTotalPrice,
      this.cartId,
      this.couponId,
      this.goodsTotalPrice,
      this.addressId,
      this.grouponPrice,
      this.checkedAddress,
      this.couponPrice,
      this.availableCouponLength,
      this.freightPrice,
      this.checkedGoodsList});

  FillInOrderModel.fromJson(Map<String, dynamic> json) {
    grouponRulesId = json['grouponRulesId'];
    actualPrice = json['actualPrice'];
    orderTotalPrice = json['orderTotalPrice'];
    cartId = json['cartId'];
    couponId = json['couponId'];
    goodsTotalPrice = json['goodsTotalPrice'];
    addressId = json['addressId'];
    grouponPrice = json['grouponPrice'];
    checkedAddress = json['checkedAddress'] != null
        ? FillInOrderCheckedAddress.fromJson(json['checkedAddress'])
        : null;
    couponPrice = json['couponPrice'];
    availableCouponLength = json['availableCouponLength'];
    freightPrice = json['freightPrice'];
    if (json['checkedGoodsList'] != null) {
      checkedGoodsList = [];
      for (var v in json['checkedGoodsList']) {
        checkedGoodsList?.add(FillInOrderCheckedGoodList.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grouponRulesId'] = grouponRulesId;
    data['actualPrice'] = actualPrice;
    data['orderTotalPrice'] = orderTotalPrice;
    data['cartId'] = cartId;
    data['couponId'] = couponId;
    data['goodsTotalPrice'] = goodsTotalPrice;
    data['addressId'] = addressId;
    data['grouponPrice'] = grouponPrice;
    if (checkedAddress != null) {
      data['checkedAddress'] = checkedAddress?.toJson();
    }
    data['couponPrice'] = couponPrice;
    data['availableCouponLength'] = availableCouponLength;
    data['freightPrice'] = freightPrice;
    if (checkedGoodsList != null) {
      data['checkedGoodsList'] =
          checkedGoodsList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FillInOrderCheckedAddress {
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

  FillInOrderCheckedAddress(
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

  FillInOrderCheckedAddress.fromJson(Map<String, dynamic> json) {
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

class FillInOrderCheckedGoodList {
  int? productId;
  String? addTime;
  int? goodsId;
  String? goodsSn;
  String? updateTime;
  int? userId;
  List<String>? specifications;
  int? number;
  String? picUrl;
  bool? deleted;
  double? price;
  bool? checked;
  int? id;
  String? goodsName;

  FillInOrderCheckedGoodList(
      {this.productId,
      this.addTime,
      this.goodsId,
      this.goodsSn,
      this.updateTime,
      this.userId,
      this.specifications,
      this.number,
      this.picUrl,
      this.deleted,
      this.price,
      this.checked,
      this.id,
      this.goodsName});

  FillInOrderCheckedGoodList.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    addTime = json['addTime'];
    goodsId = json['goodsId'];
    goodsSn = json['goodsSn'];
    updateTime = json['updateTime'];
    userId = json['userId'];
    specifications = json['specifications']?.cast<String>();
    number = json['number'];
    picUrl = json['picUrl'];
    deleted = json['deleted'];
    price = json['price'];
    checked = json['checked'];
    id = json['id'];
    goodsName = json['goodsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['addTime'] = addTime;
    data['goodsId'] = goodsId;
    data['goodsSn'] = goodsSn;
    data['updateTime'] = updateTime;
    data['userId'] = userId;
    data['specifications'] = specifications;
    data['number'] = number;
    data['picUrl'] = picUrl;
    data['deleted'] = deleted;
    data['price'] = price;
    data['checked'] = checked;
    data['id'] = id;
    data['goodsName'] = goodsName;
    return data;
  }
}
