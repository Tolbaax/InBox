import '../../entities/post_entity.dart';
import '../../repositories/post_repository.dart';

class GetMyPostsWithVideos {
  final PostRepository _repository;

  GetMyPostsWithVideos(this._repository);

  Stream<List<PostEntity>> call(String uID) =>
      _repository.getMyPostsWithVideos(uID);
}
