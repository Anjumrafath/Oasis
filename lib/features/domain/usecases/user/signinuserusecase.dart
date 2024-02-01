import '../../entity/user/userentity.dart';
import '../../repository/firebaserepository.dart';

class SignInUserUseCase {
  final FirebaseRepository repository;
  SignInUserUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.signInUser(userEntity);
  }
}
