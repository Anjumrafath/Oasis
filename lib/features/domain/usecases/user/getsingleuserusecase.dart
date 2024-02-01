import '../../entity/user/userentity.dart';
import '../../repository/firebaserepository.dart';

class GetSingleUserUseCase {
  final FirebaseRepository repository;
  GetSingleUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUser(uid);
  }
}
