import '../../entities/comment_entity.dart';
import '../../repositories/post_repository.dart';

class GetCommentsUseCase {
  final PostRepository _repository;

  GetCommentsUseCase(this._repository);

  Stream<List<CommentEntity>> call(String postID) =>
      _repository.getComments(postID);
}
