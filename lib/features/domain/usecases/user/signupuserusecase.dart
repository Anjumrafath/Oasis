import '../../entity/user/userentity.dart';
import '../../repository/firebaserepository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;
  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.signUpUser(userEntity);
  }
}
