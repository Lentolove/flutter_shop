//优惠券数据模型
class CouponModel {
  int? total;
  int? pages;
  int? limit;
  int? page;
  List<CouponItem>? xList;

  CouponModel({this.total, this.pages, this.limit, this.page, this.xList});

  CouponModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    limit = json['limit'];
    page = json['page'];
    if (json['list'] != null) {
      xList = [];
      for (var v in json['list']) {
        xList?.add(CouponItem.fromJson(v));
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

class CouponItem {
  double? min;
  String? name;
  double? discount;
  String? startTime;
  int? id;
  String? tag;
  String? endTime;
  String? desc;

  CouponItem(
      {this.min,
      this.name,
      this.discount,
      this.startTime,
      this.id,
      this.tag,
      this.endTime,
      this.desc});

  CouponItem.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    name = json['name'];
    discount = json['discount'];
    startTime = json['startTime'];
    id = json['id'];
    tag = json['tag'];
    endTime = json['endTime'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min'] = min;
    data['name'] = name;
    data['discount'] = discount;
    data['startTime'] = startTime;
    data['id'] = id;
    data['tag'] = tag;
    data['endTime'] = endTime;
    data['desc'] = desc;
    return data;
  }
}
