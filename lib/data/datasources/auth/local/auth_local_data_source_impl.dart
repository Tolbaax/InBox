import 'package:inbox/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences preferences;

  AuthLocalDataSourceImpl({required this.preferences});

  @override
  Future<void> setUserLoggedIn(String uid) async =>
      await preferences.setString(AppStrings.uID, uid);

  @override
  Future<void> removeUser() async => await preferences.remove(AppStrings.uID);

  @override
  String? getUser() => preferences.getString(AppStrings.uID);
}
