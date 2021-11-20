///订单数据模型
class OrderDetailModel {
  OrderInfo? orderInfo;
  List<OrderGood>? orderGoods;

  OrderDetailModel({this.orderInfo, this.orderGoods});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    orderInfo = json['orderInfo'] != null
        ? OrderInfo.fromJson(json['orderInfo'])
        : null;
    if (json['orderGoods'] != null) {
      orderGoods = [];
      for (var v in json['orderGoods']) {
        orderGoods?.add(OrderGood.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderInfo != null) {
      data['orderInfo'] = orderInfo?.toJson();
    }
    if (orderGoods != null) {
      data['orderGoods'] = orderGoods?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderInfo {
  String? orderStatusText;
  String? consignee;
  String? address;
  String? addTime;
  String? orderSn;
  double? actualPrice;
  double? goodsPrice;
  String? mobile;
  double? couponPrice;
  int? id;
  double? freightPrice;
  OrderInfoHandleOption? handleOption;

  OrderInfo(
      {this.orderStatusText,
      this.consignee,
      this.address,
      this.addTime,
      this.orderSn,
      this.actualPrice,
      this.goodsPrice,
      this.mobile,
      this.couponPrice,
      this.id,
      this.freightPrice,
      this.handleOption});

  OrderInfo.fromJson(Map<String, dynamic> json) {
    orderStatusText = json['orderStatusText'];
    consignee = json['consignee'];
    address = json['address'];
    addTime = json['addTime'];
    orderSn = json['orderSn'];
    actualPrice = json['actualPrice'];
    goodsPrice = json['goodsPrice'];
    mobile = json['mobile'];
    couponPrice = json['couponPrice'];
    id = json['id'];
    freightPrice = json['freightPrice'];
    handleOption = json['handleOption'] != null
        ? OrderInfoHandleOption.fromJson(json['handleOption'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderStatusText'] = orderStatusText;
    data['consignee'] = consignee;
    data['address'] = address;
    data['addTime'] = addTime;
    data['orderSn'] = orderSn;
    data['actualPrice'] = actualPrice;
    data['goodsPrice'] = goodsPrice;
    data['mobile'] = mobile;
    data['couponPrice'] = couponPrice;
    data['id'] = id;
    data['freightPrice'] = freightPrice;
    if (handleOption != null) {
      data['handleOption'] = handleOption!.toJson();
    }
    return data;
  }
}

class OrderInfoHandleOption {
  bool? cancel;
  bool? confirm;
  bool? rebuy;
  bool? pay;
  bool? comment;
  bool? delete;
  bool? refund;

  OrderInfoHandleOption(
      {this.cancel,
      this.confirm,
      this.rebuy,
      this.pay,
      this.comment,
      this.delete,
      this.refund});

  OrderInfoHandleOption.fromJson(Map<String, dynamic> json) {
    cancel = json['cancel'];
    confirm = json['confirm'];
    rebuy = json['rebuy'];
    pay = json['pay'];
    comment = json['comment'];
    delete = json['delete'];
    refund = json['refund'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cancel'] = cancel;
    data['confirm'] = confirm;
    data['rebuy'] = rebuy;
    data['pay'] = pay;
    data['comment'] = comment;
    data['delete'] = delete;
    data['refund'] = refund;
    return data;
  }
}

class OrderGood {
  int? productId;
  String? addTime;
  int? orderId;
  int? goodsId;
  String? goodsSn;
  String? updateTime;
  List<String>? specifications;
  int? number;
  String? picUrl;
  bool? deleted;
  double? price;
  int? comment;
  int? id;
  String? goodsName;

  OrderGood(
      {this.productId,
      this.addTime,
      this.orderId,
      this.goodsId,
      this.goodsSn,
      this.updateTime,
      this.specifications,
      this.number,
      this.picUrl,
      this.deleted,
      this.price,
      this.comment,
      this.id,
      this.goodsName});

  OrderGood.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    addTime = json['addTime'];
    orderId = json['orderId'];
    goodsId = json['goodsId'];
    goodsSn = json['goodsSn'];
    updateTime = json['updateTime'];
    specifications = json['specifications']?.cast<String>();
    number = json['number'];
    picUrl = json['picUrl'];
    deleted = json['deleted'];
    price = json['price'];
    comment = json['comment'];
    id = json['id'];
    goodsName = json['goodsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['addTime'] = addTime;
    data['orderId'] = orderId;
    data['goodsId'] = goodsId;
    data['goodsSn'] = goodsSn;
    data['updateTime'] = updateTime;
    data['specifications'] = specifications;
    data['number'] = number;
    data['picUrl'] = picUrl;
    data['deleted'] = deleted;
    data['price'] = price;
    data['comment'] = comment;
    data['id'] = id;
    data['goodsName'] = goodsName;
    return data;
  }
}
