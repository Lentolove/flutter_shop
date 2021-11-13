import 'package:flutter_shop/model/category_model.dart';

/// currentCategory : {"id":1008002,"name":"布艺软装","keywords":"","desc":"各种风格软装装点你的家","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/8bbcd7de60a678846664af998f57e71c.png","picUrl":"http://yanxuan.nosdn.127.net/2e2fb4f2856a021bbcd1b4c8400f2b06.png","level":"L2","sortOrder":6,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false}
/// brotherCategory : [{"id":1008002,"name":"布艺软装","keywords":"","desc":"各种风格软装装点你的家","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/8bbcd7de60a678846664af998f57e71c.png","picUrl":"http://yanxuan.nosdn.127.net/2e2fb4f2856a021bbcd1b4c8400f2b06.png","level":"L2","sortOrder":6,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1008008,"name":"被枕","keywords":"","desc":"守护你的睡眠时光","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/927bc33f7ae2895dd6c11cf91f5e3228.png","picUrl":"http://yanxuan.nosdn.127.net/b43ef7cececebe6292d2f7f590522e05.png","level":"L2","sortOrder":2,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1008009,"name":"床品件套","keywords":"","desc":"MUJI等品牌制造商出品","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/243e5bf327a87217ad1f54592f0176ec.png","picUrl":"http://yanxuan.nosdn.127.net/81f671bd36bce05d5f57827e5c88dd1b.png","level":"L2","sortOrder":4,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1008016,"name":"灯具","keywords":"","desc":"一盏灯，温暖一个家","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/c48e0d9dcfac01499a437774a915842b.png","picUrl":"http://yanxuan.nosdn.127.net/f702dc399d14d4e1509d5ed6e57acd19.png","level":"L2","sortOrder":8,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1010003,"name":"地垫","keywords":"","desc":"家里的第“五”面墙","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/83d4c87f28c993af1aa8d3e4d30a2fa2.png","picUrl":"http://yanxuan.nosdn.127.net/1611ef6458e244d1909218becfe87c4d.png","level":"L2","sortOrder":5,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1011003,"name":"床垫","keywords":"","desc":"承托你的好时光","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/316afeb3948b295dfe073e4c51f77a42.png","picUrl":"http://yanxuan.nosdn.127.net/d6e0e84961032fc70fd52a8d4d0fb514.png","level":"L2","sortOrder":3,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1011004,"name":"家饰","keywords":"","desc":"装饰你的家","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/ab0df9445d985bf6719ac415313a8e88.png","picUrl":"http://yanxuan.nosdn.127.net/79275db76b5865e6167b0fbd141f2d7e.png","level":"L2","sortOrder":9,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1015000,"name":"家具","keywords":"","desc":"大师级工艺","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/4f00675caefd0d4177892ad18bfc2df6.png","picUrl":"http://yanxuan.nosdn.127.net/d5d41841136182bf49c1f99f5c452dd6.png","level":"L2","sortOrder":7,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1017000,"name":"宠物","keywords":"","desc":"抑菌除味，打造宠物舒适空间","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/a0352c57c60ce4f68370ecdab6a30857.png","picUrl":"http://yanxuan.nosdn.127.net/dae4d6e89ab8a0cd3e8da026e4660137.png","level":"L2","sortOrder":10,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1036000,"name":"夏凉","keywords":"","desc":"夏凉床品，舒适一夏","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/13ff4decdf38fe1a5bde34f0e0cc635a.png","picUrl":"http://yanxuan.nosdn.127.net/bd17c985bacb9b9ab1ab6e9d66ee343c.png","level":"L2","sortOrder":1,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false}]
/// parentCategory : {"id":1005000,"name":"居家","keywords":"","desc":"回家，放松身心","pid":0,"iconUrl":"http://yanxuan.nosdn.127.net/a45c2c262a476fea0b9fc684fed91ef5.png","picUrl":"http://yanxuan.nosdn.127.net/e8bf0cf08cf7eda21606ab191762e35c.png","level":"L1","sortOrder":2,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false}

class CategoryTitleModel {
  CategoryTitleModel({
    this.currentCategory,
    this.brotherCategory,
    this.parentCategory,
  });

  CategoryTitleModel.fromJson(dynamic json) {
    currentCategory = json['currentCategory'] != null
        ? CategoryModel.fromJson(json['currentCategory'])
        : null;
    if (json['brotherCategory'] != null) {
      brotherCategory = [];
      json['brotherCategory'].forEach((v) {
        brotherCategory?.add(CategoryModel.fromJson(v));
      });
    }
    parentCategory = json['parentCategory'] != null
        ? CategoryModel.fromJson(json['parentCategory'])
        : null;
  }

  CategoryModel? currentCategory;
  List<CategoryModel>? brotherCategory;
  CategoryModel? parentCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (currentCategory != null) {
      map['currentCategory'] = currentCategory?.toJson();
    }
    if (brotherCategory != null) {
      map['brotherCategory'] = brotherCategory?.map((v) => v.toJson()).toList();
    }
    if (parentCategory != null) {
      map['parentCategory'] = parentCategory?.toJson();
    }
    return map;
  }
}
