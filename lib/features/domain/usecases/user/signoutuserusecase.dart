import '../../repository/firebaserepository.dart';

class SignOutUseCase {
  final FirebaseRepository repository;
  SignOutUseCase({required this.repository});

  Future<void> call() {
    return repository.signOut();
  }
}
