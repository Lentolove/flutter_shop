
///{errno: 0, data: {userInfo:
///{nickName: 13257214460,
///avatarUrl: https://yanxuan.nosdn.127.net/80841d741d7fa3073e0ae27bf487339f.jpg?imageView&quality=90&thumbnail=64x64},
///token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0aGlzIGlzIGxpdGVtYWxsIHRva2VuIiwiYXVkIjoiTUlOSUFQUCIsImlzcyI6IkxJVEVNQUxMIiwiZXhwIjoxNjM3MDU1NjQwLCJ1c2VySWQiOjcsImlhdCI6MTYzNzA0ODQ0MH0.6jRg1XjTrJ1JXwkNHOznxjn_DYtjZqVldgnd5bLJnfY},
/// errmsg: 成功}
class UserModel {
  UserUserInfo? userInfo;
  String? token;

  UserModel({this.userInfo, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null
        ? UserUserInfo.fromJson(json['userInfo'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
      data['userInfo'] = userInfo?.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class UserUserInfo {
  String? avatarUrl;
  String? nickName;

  UserUserInfo({this.avatarUrl, this.nickName});

  UserUserInfo.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatarUrl'];
    nickName = json['nickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatarUrl'] = avatarUrl;
    data['nickName'] = nickName;
    return data;
  }
}
