import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/params/post/comment_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/post_repository.dart';

class AddCommentUseCase implements UseCase<void, CommentParams> {
  final PostRepository _repository;

  AddCommentUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(CommentParams params) async {
    return await _repository.addComment(params);
  }
}
