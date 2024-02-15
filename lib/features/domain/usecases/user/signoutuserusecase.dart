import '../../repository/firebaserepository.dart';

// Use case responsible for signout.
class SignOutUseCase {
  final FirebaseRepository repository;
  SignOutUseCase({required this.repository});

  Future<void> call() {
    return repository.signOut();
  }
}
