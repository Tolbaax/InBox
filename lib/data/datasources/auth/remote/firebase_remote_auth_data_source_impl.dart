import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inbox/core/params/auth/signin_params.dart';
import 'package:inbox/core/params/auth/signup_params.dart';
import '../../../models/user_model.dart';
import 'firebase_remote_auth_data_source.dart';
import 'package:get_it/get_it.dart';

class FirebaseRemoteAuthDataSourceImpl implements FirebaseRemoteAuthDataSource {
  final FirebaseAuth auth = GetIt.instance<FirebaseAuth>();
  final FirebaseFirestore firestore = GetIt.instance<FirebaseFirestore>();

  @override
  Future<void> signIn(SignInParams params) async =>
      await auth.signInWithEmailAndPassword(
          email: params.email, password: params.password);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(SignUpParams params) async {
    final result = await auth.createUserWithEmailAndPassword(
        email: params.email, password: params.password);

    final uID = result.user!.uid;

    UserModel user = UserModel(
      uID: uID,
      username: params.username,
      name: params.name,
      email: params.email,
      profilePic: '',
      bio: '',
      isOnline: false,
      lastSeen: DateTime.now(),
      postsCount: 0,
      following: const [],
      followers: const [],
      drafts: const [],
    );

    await firestore.collection('users').doc(uID).set(user.toJson());

    await auth.currentUser!.sendEmailVerification();
  }
}
