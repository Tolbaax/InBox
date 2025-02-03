import 'package:inbox/core/params/auth/signin_params.dart';
import 'package:inbox/core/params/auth/signup_params.dart';

abstract class FirebaseRemoteAuthDataSource {
  Future<void> signUp(SignUpParams params);

  Future<void> signIn(SignInParams params);

  Future<void> signOut();
}
