import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';
import 'package:insta_cleanarchitecture/features/domain/repository/firebaserepository.dart';

class CreateUserWithImageUseCase {
  final FirebaseRepository repository;

  CreateUserWithImageUseCase({required this.repository});

  Future<void> createUserWithImage(UserEntity user, String profileUrl) {
    return repository.createUserWithImage(user, profileUrl);
  }
}
