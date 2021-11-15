class GoodDetailModel {
  List<GoodDetailSpecificationList>? specificationList;

  List<GoodDetailIssue>? issue;

  int? userHasCollect;

  String? shareImage;

  GoodDetailComment? comment;

  bool? share;

  List<GoodDetailAttribute>? attribute;

  GoodDetailBrand? brand;

  List<GoodDetailProductList>? productList;

  GoodsDetailInfo? info;

  GoodDetailModel(
      {this.specificationList,
      this.issue,
      this.userHasCollect,
      this.shareImage,
      this.comment,
      this.share,
      this.attribute,
      this.brand,
      this.productList,
      this.info});

  GoodDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['specificationList'] != null) {
      specificationList = [];
      for (var v in json['specificationList']) {
        specificationList?.add(GoodDetailSpecificationList.fromJson(v));
      }
    }
    if (json['issue'] != null) {
      issue = [];
      for (var v in json['issue']) {
        issue?.add(GoodDetailIssue.fromJson(v));
      }
    }
    userHasCollect = json['userHasCollect'];
    shareImage = json['shareImage'];
    comment = json['comment'] != null
        ? GoodDetailComment.fromJson(json['comment'])
        : null;
    share = json['share'];
    if (json['attribute'] != null) {
      attribute = [];
      for (var v in json['attribute']) {
        attribute?.add(GoodDetailAttribute.fromJson(v));
      }
    }
    brand =
        json['brand'] != null ? GoodDetailBrand.fromJson(json['brand']) : null;
    if (json['productList'] != null) {
      productList = [];
      for (var v in json['productList']) {
        productList?.add(GoodDetailProductList.fromJson(v));
      }
    }
    info = json['info'] != null ? GoodsDetailInfo.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (specificationList != null) {
      map['specificationList'] =
          specificationList?.map((v) => v.toJson()).toList();
    }
    if (issue != null) {
      map['issue'] = issue?.map((v) => v.toJson()).toList();
    }
    map['userHasCollect'] = userHasCollect;
    map['shareImage'] = shareImage;
    if (comment != null) {
      map['comment'] = comment?.toJson();
    }
    map['share'] = share;
    if (attribute != null) {
      map['attribute'] = attribute?.map((v) => v.toJson()).toList();
    }
    if (brand != null) {
      map['brand'] = brand?.toJson();
    }
    if (productList != null) {
      map['productList'] = productList?.map((v) => v.toJson()).toList();
    }
    if (info != null) {
      map['info'] = info?.toJson();
    }
    return map;
  }
}

/// name : "规格"
/// valueList : [{"id":23,"goodsId":1019002,"specification":"规格","value":"标准","picUrl":"","addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false}]
class GoodDetailSpecificationList {
  GoodDetailSpecificationList({
    this.name,
    this.valueList,
  });

  GoodDetailSpecificationList.fromJson(dynamic json) {
    name = json['name'];
    if (json['valueList'] != null) {
      valueList = [];
      json['valueList'].forEach((v) {
        valueList?.add(GoodDetailSpecificationValueList.fromJson(v));
      });
    }
  }

  String? name;
  List<GoodDetailSpecificationValueList>? valueList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    if (valueList != null) {
      map['valueList'] = valueList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 23
/// goodsId : 1019002
/// specification : "规格"
/// value : "标准"
/// picUrl : ""
/// addTime : "2018-02-01 00:00:00"
/// updateTime : "2018-02-01 00:00:00"
/// deleted : false

class GoodDetailSpecificationValueList {
  GoodDetailSpecificationValueList({
    this.id,
    this.goodsId,
    this.specification,
    this.value,
    this.picUrl,
    this.addTime,
    this.updateTime,
    this.deleted,
  });

  GoodDetailSpecificationValueList.fromJson(dynamic json) {
    id = json['id'];
    goodsId = json['goodsId'];
    specification = json['specification'];
    value = json['value'];
    picUrl = json['picUrl'];
    addTime = json['addTime'];
    updateTime = json['updateTime'];
    deleted = json['deleted'];
  }

  int? id;
  int? goodsId;
  String? specification;
  String? value;
  String? picUrl;
  String? addTime;
  String? updateTime;
  bool? deleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['goodsId'] = goodsId;
    map['specification'] = specification;
    map['value'] = value;
    map['picUrl'] = picUrl;
    map['addTime'] = addTime;
    map['updateTime'] = updateTime;
    map['deleted'] = deleted;
    return map;
  }
}

/// id : 1
/// question : "购买运费如何收取？"
/// answer : "单笔订单金额（不含运费）满88元免邮费；不满88元，每单收取10元运费。\n(港澳台地区需满"
/// addTime : "2018-02-01 00:00:00"
/// updateTime : "2018-02-01 00:00:00"
/// deleted : false

class GoodDetailIssue {
  GoodDetailIssue({
    this.id,
    this.question,
    this.answer,
    this.addTime,
    this.updateTime,
    this.deleted,
  });

  GoodDetailIssue.fromJson(dynamic json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    addTime = json['addTime'];
    updateTime = json['updateTime'];
    deleted = json['deleted'];
  }

  int? id;
  String? question;
  String? answer;
  String? addTime;
  String? updateTime;
  bool? deleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question'] = question;
    map['answer'] = answer;
    map['addTime'] = addTime;
    map['updateTime'] = updateTime;
    map['deleted'] = deleted;
    return map;
  }
}

/// data : [{"addTime":"2018-02-01 00:00:00","picList":[],"adminContent":"","nickname":"user123","id":451,"avatar":"","content":"很舒适，很宽大，回弹效果算是过得去吧。"},{"addTime":"2018-02-01 00:00:00","picList":["https://yanxuan.nosdn.127.net/920e65862ada7abdc90a557bb52bb5a9.jpg"],"adminContent":"","nickname":"user123","id":452,"avatar":"","content":"京东plus会员，现在对严选也很喜欢，节省了挑选东西的时间，喜欢的话可以放心下单。好的生活，没那么贵。"}]
/// count : 30

class GoodDetailComment {
  GoodDetailComment({
    this.data,
    this.count,
  });

  GoodDetailComment.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GoodDetailCommentData.fromJson(v));
      });
    }
    count = json['count'];
  }

  List<GoodDetailCommentData>? data;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }
}

/// addTime : "2018-02-01 00:00:00"
/// picList : []
/// adminContent : ""
/// nickname : "user123"
/// id : 451
/// avatar : ""
/// content : "很舒适，很宽大，回弹效果算是过得去吧。"

class GoodDetailCommentData {
  GoodDetailCommentData({
    this.addTime,
    this.picList,
    this.adminContent,
    this.nickname,
    this.id,
    this.avatar,
    this.content,
  });

  GoodDetailCommentData.fromJson(dynamic json) {
    addTime = json['addTime'];
    if (json['picList'] != null) {
      picList = [];
      json['picList'].forEach((v) {
        picList?.add(v);
      });
    }
    adminContent = json['adminContent'];
    nickname = json['nickname'];
    id = json['id'];
    avatar = json['avatar'];
    content = json['content'];
  }

  String? addTime;
  List<String>? picList;
  String? adminContent;
  String? nickname;
  int? id;
  String? avatar;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addTime'] = addTime;
    if (picList != null) {
      map['picList'] = picList?.map((v) => v).toList();
    }
    map['adminContent'] = adminContent;
    map['nickname'] = nickname;
    map['id'] = id;
    map['avatar'] = avatar;
    map['content'] = content;
    return map;
  }
}

/// id : 81
/// goodsId : 1019002
/// attribute : "填充成分"
/// value : "聚醚型聚氨酯"
/// addTime : "2018-02-01 00:00:00"
/// updateTime : "2018-02-01 00:00:00"
/// deleted : false

class GoodDetailAttribute {
  GoodDetailAttribute({
    this.id,
    this.goodsId,
    this.attribute,
    this.value,
    this.addTime,
    this.updateTime,
    this.deleted,
  });

  GoodDetailAttribute.fromJson(dynamic json) {
    id = json['id'];
    goodsId = json['goodsId'];
    attribute = json['attribute'];
    value = json['value'];
    addTime = json['addTime'];
    updateTime = json['updateTime'];
    deleted = json['deleted'];
  }

  int? id;
  int? goodsId;
  String? attribute;
  String? value;
  String? addTime;
  String? updateTime;
  bool? deleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['goodsId'] = goodsId;
    map['attribute'] = attribute;
    map['value'] = value;
    map['addTime'] = addTime;
    map['updateTime'] = updateTime;
    map['deleted'] = deleted;
    return map;
  }
}

class GoodDetailBrand {
  double? floorPrice;
  String? picUrl;
  bool? deleted;
  String? addTime;
  int? sortOrder;
  String? name;
  String? updateTime;
  int? id;
  String? desc;

  GoodDetailBrand(
      {this.floorPrice,
      this.picUrl,
      this.deleted,
      this.addTime,
      this.sortOrder,
      this.name,
      this.updateTime,
      this.id,
      this.desc});

  GoodDetailBrand.fromJson(Map<String, dynamic> json) {
    floorPrice = json['floorPrice'];
    picUrl = json['picUrl'];
    deleted = json['deleted'];
    addTime = json['addTime'];
    sortOrder = json['sortOrder'];
    name = json['name'];
    updateTime = json['updateTime'];
    id = json['id'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['floorPrice'] = floorPrice;
    data['picUrl'] = picUrl;
    data['deleted'] = deleted;
    data['addTime'] = addTime;
    data['sortOrder'] = sortOrder;
    data['name'] = name;
    data['updateTime'] = updateTime;
    data['id'] = id;
    data['desc'] = desc;
    return data;
  }
}

/// id : 24
/// goodsId : 1019002
/// specifications : ["标准"]
/// price : 199
/// number : 100
/// url : "http://yanxuan.nosdn.127.net/0118039f7cda342651595d994ed09567.png"
/// addTime : "2018-02-01 00:00:00"
/// updateTime : "2018-02-01 00:00:00"
/// deleted : false

class GoodDetailProductList {
  GoodDetailProductList({
    this.id,
    this.goodsId,
    this.specifications,
    this.price,
    this.number,
    this.url,
    this.addTime,
    this.updateTime,
    this.deleted,
  });

  GoodDetailProductList.fromJson(dynamic json) {
    id = json['id'];
    goodsId = json['goodsId'];
    specifications = json['specifications'] != null
        ? json['specifications'].cast<String>()
        : [];
    price = json['price'];
    number = json['number'];
    url = json['url'];
    addTime = json['addTime'];
    updateTime = json['updateTime'];
    deleted = json['deleted'];
  }

  int? id;
  int? goodsId;
  List<String>? specifications;
  double? price;
  int? number;
  String? url;
  String? addTime;
  String? updateTime;
  bool? deleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['goodsId'] = goodsId;
    map['specifications'] = specifications;
    map['price'] = price;
    map['number'] = number;
    map['url'] = url;
    map['addTime'] = addTime;
    map['updateTime'] = updateTime;
    map['deleted'] = deleted;
    return map;
  }
}

/// id : 1019002
/// goodsSn : "1019002"
/// name : "升级款护颈双人记忆枕"
/// categoryId : 1008008
/// brandId : 0
/// gallery : ["http://yanxuan.nosdn.127.net/c51baecb5f1b3ae106edca6921f74ba8.jpg","http://yanxuan.nosdn.127.net/26a804344502042242df6c3d38ccd3d4.jpg","http://yanxuan.nosdn.127.net/a3c11ba31e777302be5569b8f76eadc1.jpg","http://yanxuan.nosdn.127.net/dbb20bd6803e83b02f4880e1a4f22ad2.jpg"]
/// keywords : ""
/// brief : "共享亲密2人时光"
/// isOnSale : true
/// sortOrder : 10
/// picUrl : "http://yanxuan.nosdn.127.net/0118039f7cda342651595d994ed09567.png"
/// shareUrl : ""
/// isNew : false
/// isHot : true
/// unit : "件"
/// counterPrice : 219
/// retailPrice : 199
/// addTime : "2018-02-01 00:00:00"
/// updateTime : "2018-02-01 00:00:00"
/// deleted : false
/// detail : "......."

class GoodsDetailInfo {
  GoodsDetailInfo({
    this.id,
    this.goodsSn,
    this.name,
    this.categoryId,
    this.brandId,
    this.gallery,
    this.keywords,
    this.brief,
    this.isOnSale,
    this.sortOrder,
    this.picUrl,
    this.shareUrl,
    this.isNew,
    this.isHot,
    this.unit,
    this.counterPrice,
    this.retailPrice,
    this.addTime,
    this.updateTime,
    this.deleted,
    this.detail,
  });

  GoodsDetailInfo.fromJson(dynamic json) {
    id = json['id'];
    goodsSn = json['goodsSn'];
    name = json['name'];
    categoryId = json['categoryId'];
    brandId = json['brandId'];
    gallery = json['gallery'] != null ? json['gallery'].cast<String>() : [];
    keywords = json['keywords'];
    brief = json['brief'];
    isOnSale = json['isOnSale'];
    sortOrder = json['sortOrder'];
    picUrl = json['picUrl'];
    shareUrl = json['shareUrl'];
    isNew = json['isNew'];
    isHot = json['isHot'];
    unit = json['unit'];
    counterPrice = json['counterPrice'];
    retailPrice = json['retailPrice'];
    addTime = json['addTime'];
    updateTime = json['updateTime'];
    deleted = json['deleted'];
    detail = json['detail'];
  }

  int? id;
  String? goodsSn;
  String? name;
  int? categoryId;
  int? brandId;
  List<String>? gallery;
  String? keywords;
  String? brief;
  bool? isOnSale;
  int? sortOrder;
  String? picUrl;
  String? shareUrl;
  bool? isNew;
  bool? isHot;
  String? unit;
  double? counterPrice;
  double? retailPrice;
  String? addTime;
  String? updateTime;
  bool? deleted;
  String? detail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['goodsSn'] = goodsSn;
    map['name'] = name;
    map['categoryId'] = categoryId;
    map['brandId'] = brandId;
    map['gallery'] = gallery;
    map['keywords'] = keywords;
    map['brief'] = brief;
    map['isOnSale'] = isOnSale;
    map['sortOrder'] = sortOrder;
    map['picUrl'] = picUrl;
    map['shareUrl'] = shareUrl;
    map['isNew'] = isNew;
    map['isHot'] = isHot;
    map['unit'] = unit;
    map['counterPrice'] = counterPrice;
    map['retailPrice'] = retailPrice;
    map['addTime'] = addTime;
    map['updateTime'] = updateTime;
    map['deleted'] = deleted;
    map['detail'] = detail;
    return map;
  }
}
