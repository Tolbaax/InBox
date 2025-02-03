import '../../entities/post_entity.dart';
import '../../repositories/post_repository.dart';

class GetMyPostsWithoutVideos {
  final PostRepository _repository;

  GetMyPostsWithoutVideos(this._repository);

  Stream<List<PostEntity>> call(String uID) =>
      _repository.getMyPostsWithoutVideos(uID);
}
