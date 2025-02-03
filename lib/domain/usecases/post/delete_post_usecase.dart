import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/usecase/usecase.dart';

import '../../repositories/post_repository.dart';

class DeletePostUseCase implements UseCase<void, String> {
  final PostRepository _repository;

  DeletePostUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(String postID) async {
    return await _repository.deletePost(postID);
  }
}
