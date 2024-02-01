import '../../repository/firebaserepository.dart';

class IsSignInUseCase {
  final FirebaseRepository repository;
  IsSignInUseCase({required this.repository});

  Future<bool> call() {
    return repository.isSignIn();
  }
}
