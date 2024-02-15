import 'dart:io';

import 'package:insta_cleanarchitecture/features/domain/entity/comment/commententity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/reply/replyentity.dart';

import '../../domain/entity/user/userentity.dart';
import '../../domain/repository/firebaserepository.dart';
import '../datasources/remotedatasource/remotedatasource.dart';

// Implementation of the FirebaseRepository interface.

class FirebaseRepositoryImpli implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpli({required this.remoteDataSource});
  @override
  // Overrides the createUser method from the FirebaseRepository interface

  Future<void> createUser(UserEntity user) async =>
      remoteDataSource.createUser(user);
  // Overrides the getcurrentuid method from the FirebaseRepository interface
  @override
  Future<String> getCurrentUid() async => remoteDataSource.getCurrentUid();
  // Overrides the getsingleuser method from the FirebaseRepository interface
  @override
  Stream<List<UserEntity>> getSingleUser(String uid) =>
      remoteDataSource.getSingleUser(uid);

  // Overrides the getusers method from the FirebaseRepository interface

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) =>
      remoteDataSource.getUsers(user);

  // Overrides the issignin method from the FirebaseRepository interface

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();
  // Overrides the signinuser method from the FirebaseRepository interface

  @override
  Future<void> signInUser(UserEntity user) async =>
      remoteDataSource.signInUser(user);
  // Overrides the signout method from the FirebaseRepository interface

  @override
  Future<void> signOut() async => remoteDataSource.signOut();
  // Overrides the signupUser method from the FirebaseRepository interface

  @override
  Future<void> signUpUser(UserEntity user) async =>
      remoteDataSource.signUpUser(user);
  // Overrides the updateUser method from the FirebaseRepository interface

  @override
  Future<void> updateUser(UserEntity user) async =>
      remoteDataSource.updateUser(user);

  // Overrides the uploadimagetostorage method from the FirebaseRepository interface

  @override
  Future<String> uploadImageToStorage(
          File? file, bool isPost, String childName) async =>
      remoteDataSource.uploadImageToStorage(file, isPost, childName);
  // Overrides the createUserwithimage method from the FirebaseRepository interface
  @override
  Future<void> createUserWithImage(UserEntity user, String profileUrl) async {
    remoteDataSource.createUserWithImage(user, profileUrl);
  }

  @override
  Future<void> createPost(PostEntity post) async =>
      remoteDataSource.createPost(post);

  @override
  Future<void> deletePost(PostEntity post) async =>
      remoteDataSource.deletePost(post);

  @override
  Future<void> likePost(PostEntity post) async =>
      remoteDataSource.likePost(post);

  @override
  Stream<List<PostEntity>> readPosts(PostEntity post) =>
      remoteDataSource.readPosts(post);

  @override
  Future<void> updatePost(PostEntity post) async =>
      remoteDataSource.updatePost(post);

  @override
  Future<void> createComment(CommentEntity comment) async =>
      remoteDataSource.createComment(comment);

  @override
  Future<void> deleteComment(CommentEntity comment) async =>
      remoteDataSource.deleteComment(comment);

  @override
  Future<void> likeComment(CommentEntity comment) async =>
      remoteDataSource.likeComment(comment);

  @override
  Stream<List<CommentEntity>> readComments(String postId) =>
      remoteDataSource.readComments(postId);

  @override
  Future<void> updateComment(CommentEntity comment) async =>
      remoteDataSource.updateComment(comment);

  @override
  Stream<List<PostEntity>> readSinglePost(String postId) =>
      remoteDataSource.readSinglePost(postId);

  @override
  Future<void> createReplay(ReplayEntity replay) async =>
      remoteDataSource.createReplay(replay);

  @override
  Future<void> deleteReplay(ReplayEntity replay) async =>
      remoteDataSource.deleteReplay(replay);

  @override
  Future<void> likeReplay(ReplayEntity replay) async =>
      remoteDataSource.likeReplay(replay);

  @override
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay) =>
      remoteDataSource.readReplays(replay);

  @override
  Future<void> updateReplay(ReplayEntity replay) async =>
      remoteDataSource.updateReplay(replay);

  @override
  Future<void> followUnFollowUser(UserEntity user) async =>
      remoteDataSource.followUnFollowUser(user);

  @override
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid) =>
      remoteDataSource.getSingleOtherUser(otherUid);
}
