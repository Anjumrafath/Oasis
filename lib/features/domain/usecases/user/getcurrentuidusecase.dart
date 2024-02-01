import '../../repository/firebaserepository.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository repository;
  GetCurrentUidUseCase({required this.repository});

  Future<String> call() {
    return repository.getCurrentUid();
  }
}
