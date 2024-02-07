import 'package:insta_cleanarchitecture/features/domain/entity/reply/replyentity.dart';
import 'package:insta_cleanarchitecture/features/domain/repository/firebaserepository.dart';

class ReadReplaysUseCase {
  final FirebaseRepository repository;

  ReadReplaysUseCase({required this.repository});

  Stream<List<ReplayEntity>> call(ReplayEntity replay) {
    return repository.readReplays(replay);
  }
}
