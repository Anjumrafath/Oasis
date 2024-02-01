import 'dart:io';

import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';

import '../../../domain/entity/user/userentity.dart';

abstract class FirebaseRemoteDataSource {
  //credential
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  //user
  Stream<List<UserEntity>> getUsers(UserEntity user);
  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);

//cloud storage
  Future<String> uploadImageToStorage(
      File? file, bool isPost, String childName);
  Future<void> createUserWithImage(UserEntity user, String profileUrl);

//posts features

  Future<void> createPost(PostEntity post);
  Stream<List<PostEntity>> readPosts(PostEntity post);
  Future<void> updatePost(PostEntity post);
  Future<void> deletePost(PostEntity post);
  Future<void> likePost(PostEntity post);
}
