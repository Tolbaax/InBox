import '../../entities/post_entity.dart';
import '../../repositories/post_repository.dart';

class GetSavedPostsUseCase {
  // comment

  final PostRepository _repository;

  GetSavedPostsUseCase(this._repository);

  Stream<List<PostEntity>> call() {
    return _repository.getSavedPosts();
  }
}
