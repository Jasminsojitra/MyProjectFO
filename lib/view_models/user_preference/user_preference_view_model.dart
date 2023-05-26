import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {

  Future<dynamic> saveToken(var value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", value);
    return sp;
  }

  Future<dynamic> getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? tokens = sp.getString("token");
    return tokens;
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}
