import 'package:shared_preferences/shared_preferences.dart';

setletBeginLogin() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('login', 'loginDone');
}
