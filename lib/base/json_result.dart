///接口数据统一接口
class JsonResult<T> {
  bool isSuccess = false;
  String message = '';
  T? data;
}
