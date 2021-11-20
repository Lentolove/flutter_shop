import 'order_detail_model.dart';

//订单列表
class OrderListModel {
  int? total;
  int? pages;
  int? limit;
  int? page;
  List<OrderModel>? xList;

  OrderListModel({this.total, this.pages, this.limit, this.page, this.xList});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    limit = json['limit'];
    page = json['page'];
    if (json['list'] != null) {
      xList = [];
      for (var v in json['list']) {
        xList?.add(OrderModel.fromJson(v));
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

class OrderModel {
  String? orderStatusText;
  bool? isGroupin;
  String? orderSn;
  double? actualPrice;
  List<OrderGoodModel>? goodsList;
  int? id;
  OrderInfoHandleOption? handleOption;

  OrderModel(
      {this.orderStatusText,
      this.isGroupin,
      this.orderSn,
      this.actualPrice,
      this.goodsList,
      this.id,
      this.handleOption});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderStatusText = json['orderStatusText'];
    isGroupin = json['isGroupin'];
    orderSn = json['orderSn'];
    actualPrice = json['actualPrice'];
    if (json['goodsList'] != null) {
      goodsList = [];
      for (var v in json['goodsList']) {
        goodsList!.add(OrderGoodModel.fromJson(v));
      }
    }
    id = json['id'];
    handleOption = json['handleOption'] != null
        ? OrderInfoHandleOption.fromJson(json['handleOption'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderStatusText'] = orderStatusText;
    data['isGroupin'] = isGroupin;
    data['orderSn'] = orderSn;
    data['actualPrice'] = actualPrice;
    if (goodsList != null) {
      data['goodsList'] = goodsList?.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    if (handleOption != null) {
      data['handleOption'] = handleOption?.toJson();
    }
    return data;
  }
}

class OrderGoodModel {
  int? number;
  String? picUrl;
  double? price;
  int? id;
  String? goodsName;
  List<String>? specifications;

  OrderGoodModel(
      {this.number,
      this.picUrl,
      this.price,
      this.id,
      this.goodsName,
      this.specifications});

  OrderGoodModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    picUrl = json['picUrl'];
    price = json['price'];
    id = json['id'];
    goodsName = json['goodsName'];
    specifications = json['specifications']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['picUrl'] = picUrl;
    data['price'] = price;
    data['id'] = id;
    data['goodsName'] = goodsName;
    data['specifications'] = specifications;
    return data;
  }
}
