class LoginModelData {
  String? mobile;
  String? password;
  bool? isLogin;

  LoginModelData({this.mobile, this.password,this.isLogin});

  LoginModelData.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    password = json['password'];
    isLogin = json['isLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['isLogin'] = this.isLogin;
    return data;
  }
}
