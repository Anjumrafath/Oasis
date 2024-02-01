import '../../entity/user/userentity.dart';
import '../../repository/firebaserepository.dart';

class UpdateUserUseCase {
  final FirebaseRepository repository;
  UpdateUserUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.updateUser(userEntity);
  }
}
