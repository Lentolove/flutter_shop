class CollectionModel {
  int? total;
  int? pages;
  int? limit;
  int? page;
  List<CollectionItem>? xList;

  CollectionModel({this.total, this.pages, this.limit, this.page, this.xList});

  CollectionModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    limit = json['limit'];
    page = json['page'];
    if (json['list'] != null) {
      xList = [];
      for (var v in json['list']) {
        xList?.add(CollectionItem.fromJson(v));
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

class CollectionItem {
  String? brief;
  String? picUrl;
  int? valueId;
  String? name;
  int? id;
  int? type;
  double? retailPrice;

  CollectionItem(
      {this.brief,
      this.picUrl,
      this.valueId,
      this.name,
      this.id,
      this.type,
      this.retailPrice});

  CollectionItem.fromJson(Map<String, dynamic> json) {
    brief = json['brief'];
    picUrl = json['picUrl'];
    valueId = json['valueId'];
    name = json['name'];
    id = json['id'];
    type = json['type'];
    retailPrice = json['retailPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brief'] = brief;
    data['picUrl'] = picUrl;
    data['valueId'] = valueId;
    data['name'] = name;
    data['id'] = id;
    data['type'] = type;
    data['retailPrice'] = retailPrice;
    return data;
  }
}
