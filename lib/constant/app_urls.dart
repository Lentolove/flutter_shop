class AppUrls {
  // static const String BASE_URL = 'http://localhost:8080/wx';//本地服务器

  static const String BASE_URL = 'http://10.10.64.146:8080/wx'; //本地服务器

  static const String HOME_URL = BASE_URL + '/home/index'; //首页数据

  static const String HOME_FIRST_CATEGORY = BASE_URL + '/catalog/getfirstcategory'; //商品分类第一级

  //http://localhost:8080/wx/catalog/getsecondcategory?id=1005000
  static const String HOME_SECOND_CATEGORY=BASE_URL+'/catalog/getsecondcategory';//商品分类第二级


}
