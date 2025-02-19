import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbox/presentation/controllers/post/post_cubit.dart';
import 'package:inbox/presentation/controllers/user/user_cubit.dart';
import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';
import 'core/injection/injector.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<UserCubit>()),
            BlocProvider(create: (context) => sl<PostCubit>()),
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
