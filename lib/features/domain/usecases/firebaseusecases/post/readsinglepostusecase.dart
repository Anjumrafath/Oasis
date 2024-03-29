import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/domain/repository/firebaserepository.dart';

// Use case responsible for reading single post.
class ReadSinglePostUseCase {
  final FirebaseRepository repository;

  ReadSinglePostUseCase({required this.repository});

  Stream<List<PostEntity>> call(String postId) {
    return repository.readSinglePost(postId);
  }
}
