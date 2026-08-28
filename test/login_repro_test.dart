import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/params/auth/signin_params.dart';
import 'package:inbox/core/params/auth/signup_params.dart';
import 'package:inbox/domain/repositories/firebase_auth_repository.dart';
import 'package:inbox/domain/usecases/auth/signin_usecase.dart';
import 'package:inbox/domain/usecases/auth/signout_usecase.dart';
import 'package:inbox/domain/usecases/auth/signup_usecase.dart';
import 'package:inbox/presentation/controllers/auth/auth_cubit.dart';
import 'package:inbox/presentation/controllers/auth/auth_states.dart';
import 'package:inbox/presentation/view/login/widgets/login_form.dart';

class _FakeAuthRepository implements FirebaseAuthRepository {
  @override
  Future<Either<Failure, void>> signIn(SignInParams params) async =>
      const Right(null);

  @override
  Future<Either<Failure, void>> signUp(SignUpParams params) async =>
      const Right(null);

  @override
  Future<Either<Failure, void>> signOut() async => const Right(null);
}

void main() {
  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('dev.fluttercommunity.plus/connectivity'),
      (call) async => ['wifi'],
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('dev.fluttercommunity.plus/connectivity'),
      null,
    );
  });

  testWidgets('tap login CustomButton', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    final repo = _FakeAuthRepository();
    final cubit = AuthCubit(
      SignOutUseCase(repo),
      SignInUseCase(repo),
      SignUpUseCase(repo),
    );

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => BlocProvider<AuthCubit>.value(
          value: cubit,
          child: MaterialApp(
            home: BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {},
              builder: (context, state) {
                final c = AuthCubit.get(context);
                return Scaffold(
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 20, end: 20, top: 40),
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 100),
                              LoginForm(cubit: c, state: state),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    tester.takeException();

    await tester.enterText(
        find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');

    await tester.pump();
    tester.takeException();

    await tester.tap(find.text('Login'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    tester.takeException();
    debugPrint('AFTER TAP: exception=${tester.takeException()}');
  });
}
