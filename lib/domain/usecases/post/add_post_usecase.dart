import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/params/post/post_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/post_repository.dart';

class AddPostUseCase implements UseCase<void, PostParams> {
  final PostRepository _repository;

  AddPostUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(PostParams params) async {
    return await _repository.createPost(params);
  }
}
