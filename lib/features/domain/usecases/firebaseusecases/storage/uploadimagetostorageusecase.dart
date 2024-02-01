import 'dart:io';
import 'package:insta_cleanarchitecture/features/domain/repository/firebaserepository.dart';

class UploadImageToStorageUseCase {
  final FirebaseRepository repository;
  UploadImageToStorageUseCase({required this.repository});

  Future<String> call(File file, bool isPost, String childName) {
    return repository.uploadImageToStorage(file, isPost, childName);
  }
}
