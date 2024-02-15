import '../../entity/user/userentity.dart';
import '../../repository/firebaserepository.dart';

// Use case responsible for getting a single user.
class GetSingleUserUseCase {
  final FirebaseRepository repository;
  GetSingleUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUser(uid);
  }
}
