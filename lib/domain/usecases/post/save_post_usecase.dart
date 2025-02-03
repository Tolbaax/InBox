import 'package:dartz/dartz.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/usecase/usecase.dart';

import '../../repositories/post_repository.dart';

class SavePostUseCase implements UseCase<void, String> {
  // comment

  final PostRepository _repository;

  SavePostUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(String postID) async {
    return await _repository.savePost(postID);
  }
}
