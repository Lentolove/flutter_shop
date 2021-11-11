/// id : 1
/// name : "限时满减券"
/// desc : "全场通用"
/// tag : "无限制"
/// discount : 5
/// min : 99
/// days : 10

/// 首页优惠券
class HomeCouponEntity {
  HomeCouponEntity({
      this.id,
      this.name,
      this.desc,
      this.tag,
      this.discount,
      this.min,
      this.days,});

  HomeCouponEntity.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    tag = json['tag'];
    discount = json['discount'];
    min = json['min'];
    days = json['days'];
  }
  int? id;
  String? name;
  String? desc;
  String? tag;
  int? discount;
  int? min;
  int? days;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['desc'] = desc;
    map['tag'] = tag;
    map['discount'] = discount;
    map['min'] = min;
    map['days'] = days;
    return map;
  }
}


