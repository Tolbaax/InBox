abstract class PostStates {}

class PostInitialStates extends PostStates {}

class GetPostLoadingState extends PostStates {}

class GetPostSuccessState extends PostStates {}

class GetPostsErrorState extends PostStates {
  final String msg;

  GetPostsErrorState({required this.msg});
}

class LikePostSuccessState extends PostStates {}

class LikePostErrorState extends PostStates {}

class DeletePostLoadingState extends PostStates {}

class DeletePostSuccessState extends PostStates {}

class DeletePostErrorState extends PostStates {
  final String msg;

  DeletePostErrorState({required this.msg});
}

class SaveUnSavePostState extends PostStates {}

class SaveUnSavePostErrorState extends PostStates {
  final String msg;

  SaveUnSavePostErrorState({required this.msg});
}

class GetSavedPostsErrorState extends PostStates {
  final String msg;

  GetSavedPostsErrorState({required this.msg});
}

class GetMyPostsWithoutVideosError extends PostStates {
  final String msg;

  GetMyPostsWithoutVideosError({required this.msg});
}

class GetMyPostsWithVideosError extends PostStates {
  final String msg;

  GetMyPostsWithVideosError({required this.msg});
}
