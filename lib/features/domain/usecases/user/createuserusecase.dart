import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';

import '../../repository/firebaserepository.dart';

// Use case responsible for creating a user.
class CreateUserUseCase {
  final FirebaseRepository repository;
  CreateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}
