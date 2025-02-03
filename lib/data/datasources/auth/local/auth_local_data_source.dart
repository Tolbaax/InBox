abstract class AuthLocalDataSource {
  Future<void> setUserLoggedIn(String uid);

  Future<void> removeUser();

  String? getUser();
}