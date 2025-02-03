import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialSate());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  void changeBottomNav(int index) {
    selectedIndex = index;
    emit(ChangeBottomNavState());
  }

  Future<bool> onWillPop() async {
    if (selectedIndex != 0) {
      selectedIndex = 0;
      emit(OnWillPopState());
      return false;
    }
    return true;
  }
}
