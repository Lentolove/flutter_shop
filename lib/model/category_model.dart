///分类页面数据
class CategoryList {
  List<CategoryModel> categories;

  CategoryList(this.categories);

  factory CategoryList.fromJson(List<dynamic> parseJson) {
    List<CategoryModel> categories;
    categories = parseJson.map((i) => CategoryModel.fromJson(i)).toList();
    return CategoryList(categories);
  }
}

/// id : 1005000
/// name : "居家"
/// keywords : ""
/// desc : "回家，放松身心"
/// pid : 0
/// iconUrl : "http://yanxuan.nosdn.127.net/a45c2c262a476fea0b9fc684fed91ef5.png"
/// picUrl : "http://yanxuan.nosdn.127.net/e8bf0cf08cf7eda21606ab191762e35c.png"
/// level : "L1"
/// sortOrder : 2
/// addTime : "2018-02-01 00:00:00"
/// updateTime : "2018-02-01 00:00:00"
/// deleted : false

class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.keywords,
    this.desc,
    this.pid,
    this.iconUrl,
    this.picUrl,
    this.level,
    this.sortOrder,
    this.addTime,
    this.updateTime,
    this.deleted,
  });

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    keywords = json['keywords'];
    desc = json['desc'];
    pid = json['pid'];
    iconUrl = json['iconUrl'];
    picUrl = json['picUrl'];
    level = json['level'];
    sortOrder = json['sortOrder'];
    addTime = json['addTime'];
    updateTime = json['updateTime'];
    deleted = json['deleted'];
  }

  int? id;
  String? name;
  String? keywords;
  String? desc;
  int? pid;
  String? iconUrl;
  String? picUrl;
  String? level;
  int? sortOrder;
  String? addTime;
  String? updateTime;
  bool? deleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['keywords'] = keywords;
    map['desc'] = desc;
    map['pid'] = pid;
    map['iconUrl'] = iconUrl;
    map['picUrl'] = picUrl;
    map['level'] = level;
    map['sortOrder'] = sortOrder;
    map['addTime'] = addTime;
    map['updateTime'] = updateTime;
    map['deleted'] = deleted;
    return map;
  }
}
