import '../../repository/firebaserepository.dart';

// Use case responsible for signingIn.
class IsSignInUseCase {
  final FirebaseRepository repository;
  IsSignInUseCase({required this.repository});

  Future<bool> call() {
    return repository.isSignIn();
  }
}
