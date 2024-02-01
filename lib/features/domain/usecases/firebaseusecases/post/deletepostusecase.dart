import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/domain/repository/firebaserepository.dart';

class DeletePostUseCase {
  final FirebaseRepository repository;

  DeletePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.deletePost(post);
  }
}
