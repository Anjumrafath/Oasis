import '../../repository/firebaserepository.dart';

// Use case responsible for getting the current user's UID.
class GetCurrentUidUseCase {
  final FirebaseRepository repository;
  GetCurrentUidUseCase({required this.repository});

  Future<String> call() {
    return repository.getCurrentUid();
  }
}
