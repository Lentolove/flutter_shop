import 'package:flutter_shop/base/base_view_model.dart';

class UserViewModel extends BaseViewModel{

  bool _showTitle = false;

  String? _pictureUrl;
  String? _userName = "我是小xxx";
  int _collectionNumber = 0;
  int _footPrintfNumber = 0;
  int _couponNumber = 0;
  int _page = 1;
  int _limit = 20;
  bool _isFirst=true;

  bool get showTitle => _showTitle;

  String? get pictureUrl => _pictureUrl;

  String? get userName => _userName;

  int get footPrintfNumber => _footPrintfNumber;

  int get couponNumber => _couponNumber;

  int get collectionNumber => _collectionNumber;

  String? text;

  bool get isFirst => _isFirst;


  refreshData(){
    _userName = 'xxxx';
    notifyListeners();
  }

}