import 'dart:io';
import 'package:insta_cleanarchitecture/features/domain/repository/firebaserepository.dart';

// Use case responsible for uploading an image to storage.
class UploadImageToStorageUseCase {
  final FirebaseRepository repository;
  UploadImageToStorageUseCase({required this.repository});

  Future<String> call(File file, bool isPost, String childName) {
    return repository.uploadImageToStorage(file, isPost, childName);
  }
}
