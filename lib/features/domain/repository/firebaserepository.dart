import 'dart:io';

import 'package:insta_cleanarchitecture/features/domain/entity/comment/commententity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/reply/replyentity.dart';

import '../entity/user/userentity.dart';

abstract class FirebaseRepository {
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
  Future<void> followUnFollowUser(UserEntity user);
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid);
//Cloud Storage

  Future<String> uploadImageToStorage(
    File? file,
    bool isPost,
    String childName,
  );
  Future<void> createUserWithImage(UserEntity user, String profileUrl);

//posts features

  Future<void> createPost(PostEntity post);
  Stream<List<PostEntity>> readPosts(PostEntity post);
  Stream<List<PostEntity>> readSinglePost(String postId);
  Future<void> updatePost(PostEntity post);
  Future<void> deletePost(PostEntity post);
  Future<void> likePost(PostEntity post);

  //comment features

  Future<void> createComment(CommentEntity comment);
  Stream<List<CommentEntity>> readComments(String PostId);
  Future<void> updateComment(CommentEntity comment);
  Future<void> deleteComment(CommentEntity comment);
  Future<void> likeComment(CommentEntity comment);

  // Replay Features
  Future<void> createReplay(ReplayEntity reply);
  Stream<List<ReplayEntity>> readReplays(ReplayEntity reply);
  Future<void> updateReplay(ReplayEntity reply);
  Future<void> deleteReplay(ReplayEntity reply);
  Future<void> likeReplay(ReplayEntity reply);
}
