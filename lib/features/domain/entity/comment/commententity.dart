import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String? commentId;
  final String? postId;
  final String? creatorUid;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createAt;
  final List? likes;
  final num? totalReply;

  CommentEntity({
    this.commentId,
    this.postId,
    this.creatorUid,
    this.description,
    this.username,
    this.userProfileUrl,
    this.createAt,
    this.likes,
    this.totalReply,
  });

  @override
  List<Object?> get props => [
        commentId,
        postId,
        creatorUid,
        description,
        username,
        userProfileUrl,
        createAt,
        likes,
        totalReply,
      ];
}
