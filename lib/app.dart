import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/presentation/controllers/auth/auth_cubit.dart';
import 'config/routes/app_router.dart';
import 'core/injection/injector.dart';
import 'config/theme/app_theme.dart';
import 'presentation/controllers/chat/chat_cubit.dart';
import 'presentation/controllers/post/add_post/add_post_cubit.dart';
import 'presentation/controllers/post/post_cubit.dart';
import 'presentation/controllers/user/user_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<AuthCubit>()),
            BlocProvider(create: (context) => sl<UserCubit>()),
            BlocProvider(create: (context) => sl<AddPostCubit>()),
            BlocProvider(create: (context) => sl<PostCubit>()),
            BlocProvider(create: (context) => sl<ChatCubit>()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme(),
            onGenerateRoute: AppRouter.onGenerateRoute,
          ),
        );
      },
    );
  }
}
