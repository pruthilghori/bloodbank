import 'package:shared_preferences/shared_preferences.dart';

setletBegin() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('letBeging', 'done');
}
