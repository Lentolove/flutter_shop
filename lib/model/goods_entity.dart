import 'dart:convert';

///{
/// "id":1116011,
/// "name":"蔓越莓曲奇 200克",
/// "brief":"酥脆奶香，甜酸回味",
/// "picUrl":"http://yanxuan.nosdn.127.net/767b370d07f3973500db54900bcbd2a7.png",
/// "isNew":true,
/// "isHot":true,
/// "counterPrice":56,
/// "retailPrice":36
/// }

class GoodsEntity {
  String brief;
  String picUrl;
  String name;
  double counterPrice;
  int id;
  bool isNew;
  double retailPrice;
  bool isHot;

  GoodsEntity(
      {required this.brief,
      required this.picUrl,
      required this.name,
      required this.counterPrice,
      required this.id,
      required this.isNew,
      required this.retailPrice,
      required this.isHot});

  factory GoodsEntity.fromJson(Map<String, dynamic> json) => GoodsEntity(
      brief: json['brief'],
      picUrl: json['picUrl'],
      name: json['name'],
      counterPrice: json['counterPrice'],
      id: json['id'],
      isNew: json['isNew'],
      retailPrice: json['retailPrice'],
      isHot: json['isHot']);

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
    return data;
  }
}
