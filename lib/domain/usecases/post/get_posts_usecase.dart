import '../../entities/post_entity.dart';
import '../../repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository _repository;

  GetPostsUseCase(this._repository);

  Stream<List<PostEntity>> call() => _repository.getPosts();
}
