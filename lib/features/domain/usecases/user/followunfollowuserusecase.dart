import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';
import 'package:insta_cleanarchitecture/features/domain/repository/firebaserepository.dart';

class FollowUnFollowUseCase {
  final FirebaseRepository repository;

  FollowUnFollowUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.followUnFollowUser(user);
  }
}
