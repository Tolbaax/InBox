import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../core/injection/injector.dart';
import '../../components/common/user_not_logged.dart';
import '../../controllers/layout/layout_cubit.dart';
import '../../controllers/layout/layout_states.dart';
import '../../controllers/user/user_cubit.dart';
import 'widgets/custom_bottom_nav_bar.dart';
import 'widgets/custom_floating_button.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with WidgetsBindingObserver {
  late final UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _userCubit = BlocProvider.of<UserCubit>(context);
    _getUserData();
    _userCubit.setUserState(isOnline: true);
  }

  //To check online and offline mode
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final isOnline = state == AppLifecycleState.resumed;
    _userCubit.setUserState(isOnline: isOnline);
  }

  void _getUserData() {
    _userCubit.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is ChangeBottomNavState &&
            LayoutCubit.get(context).selectedIndex == 3) {
          _userCubit.getCurrentUser();
        }
      },
      builder: (context, state) {
        final cubit = context.read<LayoutCubit>();
        final firebaseAuth = sl<FirebaseAuth>();
        final user = firebaseAuth.currentUser;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            await cubit.onPopInvokedWithResult(context);
          },
          child: Scaffold(
            appBar: AppBar(toolbarHeight: 0.0),
            resizeToAvoidBottomInset: false,
            extendBody: true,
            floatingActionButton: const CustomFloatingButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: CustomBottomNavBar(cubit: cubit),
            body: user == null
                ? const UserNotLogged()
                : Constants.screens[cubit.selectedIndex],
          ),
        );
      },
    );
  }
}
