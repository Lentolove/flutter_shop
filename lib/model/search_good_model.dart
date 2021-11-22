import 'package:flutter_shop/model/home_model.dart';

///商品搜索数据模型
class SearchGoodsModel {
  int? total;
  int? pages;
  int? limit;
  int? page;
  List<GoodsModel>? xList;
  List<SearchGoodItem>? filterCategoryList;

  SearchGoodsModel(
      {this.total,
      this.pages,
      this.limit,
      this.page,
      this.xList,
      this.filterCategoryList});

  SearchGoodsModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    limit = json['limit'];
    page = json['page'];
    if (json['list'] != null) {
      xList = [];
      for (var v in json['list']) {
        xList!.add(GoodsModel.fromJson(v));
      }
    }
    if (json['filterCategoryList'] != null) {
      filterCategoryList = [];
      for (var v in json['filterCategoryList']) {
        filterCategoryList!.add(SearchGoodItem.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = total;
    data['pages'] = pages;
    data['limit'] = limit;
    data['page'] = page;
    if (xList != null) {
      data['list'] = xList!.map((v) => v.toJson()).toList();
    }
    if (filterCategoryList != null) {
      data['filterCategoryList'] =
          filterCategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchGoodItem {
  String? picUrl;
  bool? deleted;
  String? keywords;
  String? addTime;
  String? level;
  int? sortOrder;
  String? name;
  int? pid;
  String? updateTime;
  int? id;
  String? iconUrl;
  String? desc;

  SearchGoodItem(
      {this.picUrl,
      this.deleted,
      this.keywords,
      this.addTime,
      this.level,
      this.sortOrder,
      this.name,
      this.pid,
      this.updateTime,
      this.id,
      this.iconUrl,
      this.desc});

  SearchGoodItem.fromJson(Map<String, dynamic> json) {
    picUrl = json['picUrl'];
    deleted = json['deleted'];
    keywords = json['keywords'];
    addTime = json['addTime'];
    level = json['level'];
    sortOrder = json['sortOrder'];
    name = json['name'];
    pid = json['pid'];
    updateTime = json['updateTime'];
    id = json['id'];
    iconUrl = json['iconUrl'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['picUrl'] = picUrl;
    data['deleted'] = deleted;
    data['keywords'] = keywords;
    data['addTime'] = addTime;
    data['level'] = level;
    data['sortOrder'] = sortOrder;
    data['name'] = name;
    data['pid'] = pid;
    data['updateTime'] = updateTime;
    data['id'] = id;
    data['iconUrl'] = iconUrl;
    data['desc'] = desc;
    return data;
  }
}
