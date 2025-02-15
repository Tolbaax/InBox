import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/presentation/controllers/messages/messages_cubit.dart';
import '../../../core/injection/injector.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialSate());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  void changeBottomNav(int index) {
    selectedIndex = index;
    final messageCubit = sl<MessagesCubit>();
    if (messageCubit.selectedChatIds.isNotEmpty) {
      messageCubit.removeSelectedChats();
    }
    emit(ChangeBottomNavState());
  }

  Future<void> onPopInvokedWithResult(context) async {
    if (selectedIndex != 0) {
      selectedIndex = 0;
      emit(OnWillPopState());
    } else {
      SystemNavigator.pop();
    }
  }
}
