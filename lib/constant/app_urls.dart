class AppUrls {
  // static const String BASE_URL = 'http://localhost:8080/wx';//本地服务器

  // static const String BASE_URL = 'http://10.10.64.146:8080/wx'; //本地服务器
  static const String BASE_URL = 'http://192.168.1.105:8080/wx'; //本地服务器

  static const String HOME_URL = BASE_URL + '/home/index'; //首页数据

  static const String HOME_FIRST_CATEGORY =
      BASE_URL + '/catalog/getfirstcategory'; //商品分类第一级

  //http://localhost:8080/wx/catalog/getsecondcategory?id=1005000
  static const String HOME_SECOND_CATEGORY =
      BASE_URL + '/catalog/getsecondcategory'; //商品分类第二级

  static const String GOODS_LIST_URL = BASE_URL + '/goods/list'; //分类下的商品列表

  static const String CATEGORY_LIST = BASE_URL + "/goods/category"; //获取分类下的子类

  static const String GOODS_DETAILS_URL = BASE_URL + '/goods/detail'; //商品详情

  //用户信息相关接口
  static const String REGISTER = BASE_URL + '/auth/register'; //注册

  static const String LOGIN = BASE_URL + '/auth/login'; //登录

  // ---- 购物车相关 ----- //
  static const String ADD_CART = BASE_URL + '/cart/add'; //加入购物车

  static const String CART_LIST = BASE_URL + '/cart/index'; //购物车数据

  static const String CART_CHECK=BASE_URL+'/cart/checked';//购物车商品勾选计算价格

  static const String CART_DELETE=BASE_URL+'/cart/delete';//删除购物车数据

  static const String CART_UPDATE=BASE_URL+'/cart/update';//更新购物车

  static const String CART_BUY=BASE_URL+'/cart/checkout';//购物车下单

  static const String SUBMIT_ORDER=BASE_URL+ '/order/submit';// 提交订单

}
