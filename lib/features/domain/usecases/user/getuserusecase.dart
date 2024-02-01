import '../../entity/user/userentity.dart';
import '../../repository/firebaserepository.dart';

class GetUsersUseCase {
  final FirebaseRepository repository;
  GetUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call(UserEntity userEntity) {
    return repository.getUsers(userEntity);
  }
}
