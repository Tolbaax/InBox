import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/usecase/usecase.dart';
import 'package:inbox/domain/repositories/post_repository.dart';

class IsPostInDraftsUseCase implements UseCase<bool, String> {
  // comment

  final PostRepository _repository;

  IsPostInDraftsUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(String postID) async {
    return await _repository.isPostInDrafts(postID);
  }
}
