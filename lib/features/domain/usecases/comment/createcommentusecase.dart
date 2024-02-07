import 'package:insta_cleanarchitecture/features/domain/entity/comment/commententity.dart';
import 'package:insta_cleanarchitecture/features/domain/repository/firebaserepository.dart';

class CreateCommentUseCase {
  final FirebaseRepository repository;

  CreateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.createComment(comment);
  }
}
