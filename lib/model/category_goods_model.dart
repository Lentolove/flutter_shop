import 'package:flutter_shop/model/home_model.dart';

import 'category_model.dart';

/// total : 238
/// pages : 24
/// limit : 10
/// page : 1
/// list : [{"id":1006002,"name":"轻奢纯棉刺绣水洗四件套","brief":"设计师原款，精致绣花","picUrl":"http://yanxuan.nosdn.127.net/8ab2d3287af0cefa2cc539e40600621d.png","isNew":false,"isHot":false,"counterPrice":919.00,"retailPrice":899.00},{"id":1006007,"name":"秋冬保暖加厚澳洲羊毛被","brief":"臻品级澳洲进口羊毛","picUrl":"http://yanxuan.nosdn.127.net/66425d1ed50b3968fed27c822fdd32e0.png","isNew":false,"isHot":false,"counterPrice":479.00,"retailPrice":459.00},{"id":1006013,"name":"双宫茧桑蚕丝被 空调被","brief":"一级桑蚕丝，吸湿透气柔软","picUrl":"http://yanxuan.nosdn.127.net/583812520c68ca7995b6fac4c67ae2c7.png","isNew":false,"isHot":true,"counterPrice":719.00,"retailPrice":699.00},{"id":1006014,"name":"双宫茧桑蚕丝被 子母被","brief":"双层子母被，四季皆可使用","picUrl":"http://yanxuan.nosdn.127.net/2b537159f0f789034bf8c4b339c43750.png","isNew":false,"isHot":true,"counterPrice":14199.00,"retailPrice":1399.00},{"id":1006051,"name":"皇室御用超柔毛巾","brief":"至柔至软，热销50万条","picUrl":"http://yanxuan.nosdn.127.net/ad5a317216f9da495b144070ecf1f957.png","isNew":false,"isHot":false,"counterPrice":79.00,"retailPrice":59.00},{"id":1009009,"name":"白鹅绒秋冬加厚羽绒被","brief":"热销5万条，一条被子过冬","picUrl":"http://yanxuan.nosdn.127.net/9791006f25e26b2d7c81f41f87ce8619.png","isNew":false,"isHot":false,"counterPrice":2019.00,"retailPrice":1999.00},{"id":1009012,"name":"可水洗舒柔丝羽绒枕","brief":"超细纤维，蓬松轻盈回弹","picUrl":"http://yanxuan.nosdn.127.net/a196b367f23ccfd8205b6da647c62b84.png","isNew":false,"isHot":true,"counterPrice":79.00,"retailPrice":59.00},{"id":1009013,"name":"可水洗抗菌防螨丝羽绒枕","brief":"进口防螨布，热销50万件","picUrl":"http://yanxuan.nosdn.127.net/da56fda947d0f430d5f4cf4aba14e679.png","isNew":false,"isHot":false,"counterPrice":119.00,"retailPrice":99.00},{"id":1009024,"name":"日式和风懒人沙发","brief":"优质莱卡纯棉，和风家居新体验","picUrl":"http://yanxuan.nosdn.127.net/149dfa87a7324e184c5526ead81de9ad.png","isNew":false,"isHot":false,"counterPrice":619.00,"retailPrice":599.00},{"id":1009027,"name":"皇室御用超柔毛巾80s","brief":"轻柔舒适不掉毛","picUrl":"http://yanxuan.nosdn.127.net/71cfd849335c498dee3c54d1eb823c17.png","isNew":false,"isHot":false,"counterPrice":99.00,"retailPrice":79.00}]
/// filterCategoryList : [{"id":1005007,"name":"锅具","keywords":"","desc":"一口好锅，炖煮生活一日三餐","pid":1005001,"iconUrl":"http://yanxuan.nosdn.127.net/4aab4598017b5749e3b63309d25e9f6b.png","picUrl":"http://yanxuan.nosdn.127.net/d2db0d1d0622c621a8aa5a7c06b0fc6d.png","level":"L2","sortOrder":1,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1008001,"name":"毛巾","keywords":"","desc":"日本皇室专供，内野制造商出品","pid":1013001,"iconUrl":"http://yanxuan.nosdn.127.net/44ad9a739380aa6b7cf956fb2a06e7a7.png","picUrl":"http://yanxuan.nosdn.127.net/c53d2dd5ba6b1cfb55bd42ea0783f051.png","level":"L2","sortOrder":1,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1008002,"name":"布艺软装","keywords":"","desc":"各种风格软装装点你的家","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/8bbcd7de60a678846664af998f57e71c.png","picUrl":"http://yanxuan.nosdn.127.net/2e2fb4f2856a021bbcd1b4c8400f2b06.png","level":"L2","sortOrder":6,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1008008,"name":"被枕","keywords":"","desc":"守护你的睡眠时光","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/927bc33f7ae2895dd6c11cf91f5e3228.png","picUrl":"http://yanxuan.nosdn.127.net/b43ef7cececebe6292d2f7f590522e05.png","level":"L2","sortOrder":2,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1008009,"name":"床品件套","keywords":"","desc":"MUJI等品牌制造商出品","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/243e5bf327a87217ad1f54592f0176ec.png","picUrl":"http://yanxuan.nosdn.127.net/81f671bd36bce05d5f57827e5c88dd1b.png","level":"L2","sortOrder":4,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1008015,"name":"糕点","keywords":"","desc":"四季糕点，用心烘焙","pid":1005002,"iconUrl":"http://yanxuan.nosdn.127.net/93168242df456b5f7bf3c89653b3db76.png","picUrl":"http://yanxuan.nosdn.127.net/66ea1d6ad602a8e441af7cada93bdc7a.png","level":"L2","sortOrder":1,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1008016,"name":"灯具","keywords":"","desc":"一盏灯，温暖一个家","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/c48e0d9dcfac01499a437774a915842b.png","picUrl":"http://yanxuan.nosdn.127.net/f702dc399d14d4e1509d5ed6e57acd19.png","level":"L2","sortOrder":8,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1010002,"name":"内裤","keywords":"","desc":"来自李维斯、爱慕等制造商","pid":1010000,"iconUrl":"http://yanxuan.nosdn.127.net/364269344ed69adafe1b70ab7998fc50.png","picUrl":"http://yanxuan.nosdn.127.net/0a7fe0a08c195ca2cf55d12cd3c30f09.png","level":"L2","sortOrder":1,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1011004,"name":"家饰","keywords":"","desc":"装饰你的家","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/ab0df9445d985bf6719ac415313a8e88.png","picUrl":"http://yanxuan.nosdn.127.net/79275db76b5865e6167b0fbd141f2d7e.png","level":"L2","sortOrder":9,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1012001,"name":"功能箱包","keywords":"","desc":"范思哲、Coach等品牌制造商出品","pid":1008000,"iconUrl":"http://yanxuan.nosdn.127.net/3050a2b3052d766c4b460d4b766353a3.png","picUrl":"http://yanxuan.nosdn.127.net/0645dcda6172118f9295630c2a6f234f.png","level":"L2","sortOrder":1,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1012003,"name":"文具","keywords":"","desc":"找回书写的力量","pid":1012000,"iconUrl":"http://yanxuan.nosdn.127.net/e1743239e41ca9af76875aedc73be7f0.png","picUrl":"http://yanxuan.nosdn.127.net/e074795f61a83292d0f20eb7d124e2ac.png","level":"L2","sortOrder":1,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1015000,"name":"家具","keywords":"","desc":"大师级工艺","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/4f00675caefd0d4177892ad18bfc2df6.png","picUrl":"http://yanxuan.nosdn.127.net/d5d41841136182bf49c1f99f5c452dd6.png","level":"L2","sortOrder":7,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1017000,"name":"宠物","keywords":"","desc":"抑菌除味，打造宠物舒适空间","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/a0352c57c60ce4f68370ecdab6a30857.png","picUrl":"http://yanxuan.nosdn.127.net/dae4d6e89ab8a0cd3e8da026e4660137.png","level":"L2","sortOrder":10,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1020003,"name":"服饰","keywords":"","desc":"萌宝穿搭，柔软舒适触感","pid":1011000,"iconUrl":"http://yanxuan.nosdn.127.net/4e50f3c4e4d0a64cd0ad14cfc0b6bd17.png","picUrl":"http://yanxuan.nosdn.127.net/004f5f96df4aeb0645abbd70c0637239.png","level":"L2","sortOrder":1,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1032000,"name":"魔兽世界","keywords":"","desc":"艾泽拉斯的冒险，才刚刚开始","pid":1019000,"iconUrl":"http://yanxuan.nosdn.127.net/336f0186a9920eb0f93a3912f3662ffe.png","picUrl":"http://yanxuan.nosdn.127.net/becfba90e8a5c95d403b8a6b9bb77825.png","level":"L2","sortOrder":1,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false},{"id":1036000,"name":"夏凉","keywords":"","desc":"夏凉床品，舒适一夏","pid":1005000,"iconUrl":"http://yanxuan.nosdn.127.net/13ff4decdf38fe1a5bde34f0e0cc635a.png","picUrl":"http://yanxuan.nosdn.127.net/bd17c985bacb9b9ab1ab6e9d66ee343c.png","level":"L2","sortOrder":1,"addTime":"2018-02-01 00:00:00","updateTime":"2018-02-01 00:00:00","deleted":false}]

///接口地址：http://localhost:8080/wx/goods/list

class CategoryGoodsListModel {
  CategoryGoodsListModel({
    this.total,
    this.pages,
    this.limit,
    this.page,
    this.list,
    this.filterCategoryList,
  });

  CategoryGoodsListModel.fromJson(dynamic json) {
    total = json['total'];
    pages = json['pages'];
    limit = json['limit'];
    page = json['page'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(GoodsModel.fromJson(v));
      });
    }
    if (json['filterCategoryList'] != null) {
      filterCategoryList = [];
      json['filterCategoryList'].forEach((v) {
        filterCategoryList?.add(CategoryModel.fromJson(v));
      });
    }
  }

  int? total;
  int? pages;
  int? limit;
  int? page;
  List<GoodsModel>? list;
  List<CategoryModel>? filterCategoryList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['pages'] = pages;
    map['limit'] = limit;
    map['page'] = page;
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    if (filterCategoryList != null) {
      map['filterCategoryList'] =
          filterCategoryList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
