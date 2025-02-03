import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:inbox/data/datasources/chat/chat_remote_data_source.dart';
import 'package:inbox/data/datasources/chat/chat_remote_data_source_impl.dart';
import 'package:inbox/data/repositories/chat_repository_impl.dart';
import 'package:inbox/domain/repositories/chat_repository.dart';
import 'package:inbox/presentation/controllers/chat/chat_cubit.dart';
import 'package:inbox/data/datasources/auth/local/auth_local_data_source.dart';
import 'package:inbox/data/datasources/auth/local/auth_local_data_source_impl.dart';
import 'package:inbox/data/datasources/auth/remote/firebase_remote_auth_data_source.dart';
import 'package:inbox/data/datasources/auth/remote/firebase_remote_auth_data_source_impl.dart';
import 'package:inbox/data/datasources/post/post_remote_data_source.dart';
import 'package:inbox/data/datasources/post/post_remote_data_source_impl.dart';
import 'package:inbox/data/datasources/user/user_remote_data_source.dart';
import 'package:inbox/data/datasources/user/user_remote_data_source_impl.dart';
import 'package:inbox/data/repositories/firebase_auth_repository_impl.dart';
import 'package:inbox/data/repositories/post_repository_impl.dart';
import 'package:inbox/data/repositories/user_repository_impl.dart';
import 'package:inbox/domain/usecases/auth/signin_usecase.dart';
import 'package:inbox/domain/usecases/auth/signout_usecase.dart';
import 'package:inbox/domain/usecases/auth/signup_usecase.dart';
import 'package:inbox/domain/usecases/user/follow_user_use_case.dart';
import 'package:inbox/domain/usecases/user/get_current_uid_usecase.dart';
import 'package:inbox/domain/usecases/user/get_current_user_usecase.dart';
import 'package:inbox/domain/usecases/user/get_user_by_id_usecase.dart';
import 'package:inbox/domain/usecases/user/set_user_state_usecase.dart';
import 'package:inbox/domain/usecases/user/unfollow_user_use_case.dart';
import 'package:inbox/domain/usecases/user/update_user_data.dart';
import 'package:inbox/domain/usecases/chat/get_chat_messages_usecase.dart';
import 'package:inbox/domain/usecases/chat/get_num_of_message_not_seen_usecase.dart';
import 'package:inbox/domain/usecases/chat/get_users_chat_usecase.dart';
import 'package:inbox/domain/usecases/chat/send_file_message_usecase.dart';
import 'package:inbox/domain/usecases/chat/send_gif_message_usecase.dart';
import 'package:inbox/domain/usecases/chat/send_text_message_usecase.dart';
import 'package:inbox/domain/usecases/chat/set_chat_message_seen.dart';
import 'package:inbox/domain/usecases/post/add_comment_usecase.dart';
import 'package:inbox/domain/usecases/post/add_post_usecase.dart';
import 'package:inbox/domain/usecases/post/delete_post_usecase.dart';
import 'package:inbox/domain/usecases/post/get_comments_usecase.dart';
import 'package:inbox/domain/usecases/post/get_my_posts_with_videos_usecase.dart';
import 'package:inbox/domain/usecases/post/get_my_posts_without_videos_usecase.dart';
import 'package:inbox/domain/usecases/post/get_posts_usecase.dart';
import 'package:inbox/domain/usecases/post/get_saved_posts_usecase.dart';
import 'package:inbox/domain/usecases/post/is_post_in_drafts_usecase.dart';
import 'package:inbox/domain/usecases/post/like_post_usecase.dart';
import 'package:inbox/domain/usecases/post/save_post_usecase.dart';
import 'package:inbox/domain/usecases/user/delete_user_account.dart';
import 'package:inbox/presentation/controllers/auth/auth_cubit.dart';
import 'package:inbox/presentation/controllers/layout/layout_cubit.dart';
import 'package:inbox/presentation/controllers/post/add_post/add_post_cubit.dart';
import 'package:inbox/presentation/controllers/post/comment/comment_cubit.dart';
import 'package:inbox/presentation/controllers/post/post_cubit.dart';
import 'package:inbox/presentation/controllers/user/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/firebase_auth_repository.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/repositories/user_repository.dart';

final sl = GetIt.instance;

// Main initialization function
Future<void> init() async {
  await registerSharedPreferences();
  registerCubits();
  registerUseCases();
  registerRepositories();
  registerDataSources();
  registerExternalDependencies();
}

// Register shared preferences
Future<void> registerSharedPreferences() async {
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPref);
}

// Register Cubits
void registerCubits() {
  sl.registerLazySingleton(() => AuthCubit(sl(), sl(), sl()));
  sl.registerLazySingleton(() => LayoutCubit());
  sl.registerLazySingleton(
      () => UserCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(
      () => PostCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => AddPostCubit(sl()));
  sl.registerLazySingleton(() => CommentCubit(sl(), sl()));
  sl.registerLazySingleton(
      () => ChatCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
}

// Register UseCases
void registerUseCases() {
  // Auth UseCases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  // User
  sl.registerLazySingleton(() => GetCurrentUIDUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => SetUserStateUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserDataUseCase(sl()));
  sl.registerLazySingleton(() => GetUserByIdUseCase(sl()));
  sl.registerLazySingleton(() => FollowUserUseCase(sl()));
  sl.registerLazySingleton(() => UnFollowUserUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserAccountUseCase(sl()));
  // Post
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => GetPostsUseCase(sl()));
  sl.registerLazySingleton(() => LikePostUseCase(sl()));
  sl.registerLazySingleton(() => AddCommentUseCase(sl()));
  sl.registerLazySingleton(() => GetCommentsUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => SavePostUseCase(sl()));
  sl.registerLazySingleton(() => IsPostInDraftsUseCase(sl()));
  sl.registerLazySingleton(() => GetSavedPostsUseCase(sl()));
  sl.registerLazySingleton(() => GetMyPostsWithoutVideos(sl()));
  sl.registerLazySingleton(() => GetMyPostsWithVideos(sl()));
  // Chat
  sl.registerLazySingleton(() => GetChatMessagesUseCase(sl()));
  sl.registerLazySingleton(() => GetNumberOfMessageNotSeenUseCase(sl()));
  sl.registerLazySingleton(() => GetUsersChatUseCase(sl()));
  sl.registerLazySingleton(() => SendTextMessageUseCase(sl()));
  sl.registerLazySingleton(() => SendFileMessageUseCase(sl()));
  sl.registerLazySingleton(() => SendGifMessageUseCase(sl()));
  sl.registerLazySingleton(() => SetChatMessageSeenUseCase(sl()));
}

// Register Repositories
void registerRepositories() {
  sl.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(
            authDataSource: sl(),
            localDataSource: sl(),
            userRemoteDataSource: sl(),
          ));

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRemoteDataSource: sl()));

  sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(postRemoteDataSource: sl()));

  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));
}

// Register Data Sources
void registerDataSources() {
  // Remote Data Sources
  sl.registerLazySingleton<FirebaseRemoteAuthDataSource>(
      () => FirebaseRemoteAuthDataSourceImpl(sl(), sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(sl(), sl(), sl(), sl()));

  // Local Data Source
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(preferences: sl()));
}

// Register External Dependencies
void registerExternalDependencies() {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
  sl.registerLazySingleton(() => firebaseStorage);
}
