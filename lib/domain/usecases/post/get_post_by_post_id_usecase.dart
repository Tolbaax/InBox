import 'package:inbox/domain/entities/post_entity.dart';

import '../../repositories/post_repository.dart';

class GetPostByPostIDUseCase {
  final PostRepository _repository;

  GetPostByPostIDUseCase(this._repository);

  Stream<PostEntity> call(String postID) => _repository.getPostByPostID(postID);
}
