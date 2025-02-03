import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inbox/core/params/auth/signin_params.dart';
import 'package:inbox/core/params/auth/signup_params.dart';
import '../../../models/user_model.dart';
import 'firebase_remote_auth_data_source.dart';

class FirebaseRemoteAuthDataSourceImpl implements FirebaseRemoteAuthDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteAuthDataSourceImpl(this.auth, this.firestore);

  @override
  Future<void> signIn(SignInParams params) async =>
      await auth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(SignUpParams params) async {
    final result = await auth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    final uID = result.user!.uid;

    UserModel user = UserModel(
      uID: uID,
      username: params.username,
      name: params.name,
      email: params.email,
      profilePic: '',
      bio: 'Write your bio here..',
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
