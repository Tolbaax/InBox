import 'package:dartz/dartz.dart';
import 'package:inbox/core/params/post/like_post_params.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/post_repository.dart';

class LikePostUseCase implements UseCase<void, LikePostParams> {
  final PostRepository _repository;

  LikePostUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(LikePostParams params) async {
    return await _repository.likePost(params);
  }
}
