///我的足迹数据模型
class FootPrintModel {
  int? total;
  int? pages;
  int? limit;
  int? page;
  List<FootPrintItem>? xList;

  FootPrintModel({this.total, this.pages, this.limit, this.page, this.xList});

  FootPrintModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    limit = json['limit'];
    page = json['page'];
    if (json['list'] != null) {
      xList = [];
      for (var v in json['list']) {
        xList!.add(FootPrintItem.fromJson(v));
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
      data['list'] = xList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FootPrintItem {
  String? brief;
  String? picUrl;
  String? name;
  double? counterPrice;
  int? id;
  bool? isNew;
  double? retailPrice;
  bool? isHot;
  bool? isCheck = false;
  int? goodsId;

  FootPrintItem(
      {this.brief,
      this.picUrl,
      this.name,
      this.counterPrice,
      this.id,
      this.isNew,
      this.retailPrice,
      this.isHot,
      this.goodsId,
      this.isCheck});

  FootPrintItem.fromJson(Map<String, dynamic> json) {
    brief = json['brief'];
    picUrl = json['picUrl'];
    name = json['name'];
    counterPrice = json['counterPrice'];
    id = json['id'];
    goodsId = json['goodsId'];
    isNew = json['isNew'];
    retailPrice = json['retailPrice'];
    isHot = json['isHot'];
    isCheck = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brief'] = brief;
    data['picUrl'] = picUrl;
    data['name'] = name;
    data['counterPrice'] = counterPrice;
    data['id'] = id;
    data['isNew'] = isNew;
    data['retailPrice'] = retailPrice;
    data['isHot'] = isHot;
    data['goodsId'] = goodsId;
    data['isCheck'] = isCheck;
    return data;
  }
}
