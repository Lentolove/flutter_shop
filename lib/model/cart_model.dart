class CartModel {
  CartTotalBean? cartTotal;
  List<CartBean>? cartList;

  CartModel({this.cartTotal, this.cartList});

  CartModel.fromJson(Map<String, dynamic> json) {
    cartTotal = json['cartTotal'] != null
        ? CartTotalBean.fromJson(json['cartTotal'])
        : null;
    if (json['cartList'] != null) {
      cartList = [];
      for (var v in (json['cartList'])) {
        cartList?.add(CartBean.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartTotal != null) {
      data['cartTotal'] = cartTotal?.toJson();
    }
    if (cartList != null) {
      data['cartList'] = cartList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartTotalBean {
  int? goodsCount;
  int? checkedGoodsCount;
  var goodsAmount;
  var checkedGoodsAmount;

  CartTotalBean(
      {this.goodsCount,
      this.checkedGoodsCount,
      this.goodsAmount,
      this.checkedGoodsAmount});

  CartTotalBean.fromJson(Map<String, dynamic> json) {
    goodsCount = json['goodsCount'];
    checkedGoodsCount = json['checkedGoodsCount'];
    goodsAmount = json['goodsAmount'];
    checkedGoodsAmount = json['checkedGoodsAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['goodsCount'] = goodsCount;
    data['checkedGoodsCount'] = checkedGoodsCount;
    data['goodsAmount'] = goodsAmount;
    data['checkedGoodsAmount'] = checkedGoodsAmount;
    return data;
  }
}

class CartBean {
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

  CartBean(
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

  CartBean.fromJson(Map<String, dynamic> json) {
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
