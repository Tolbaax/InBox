import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/params/post/post_params.dart';
import '../../../../domain/usecases/post/add_post_usecase.dart';
import 'add_post_mixin.dart';
import 'add_post_states.dart';

class AddPostCubit extends Cubit<AddPostStates> with AddPostMixin {
  final AddPostUseCase _addPostUseCase;

  AddPostCubit(this._addPostUseCase) : super(AddPostInitialStates());

  static AddPostCubit get(context) => BlocProvider.of(context);

  Future<void> addPost() async {
    emit(AddPostLoadingState());
    final result = await _addPostUseCase(
      PostParams(
        postText: postTextController.text.trim(),
        imageFile: postImage,
        videoFile: video,
        gifUrl: gifUrl ?? '',
      ),
    );

    result.fold(
      (l) => emit(AddPostErrorState()),
      (r) => emit(AddPostSuccessState()),
    );
  }
}
