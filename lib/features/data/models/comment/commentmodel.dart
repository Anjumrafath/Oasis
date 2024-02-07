import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/comment/commententity.dart';

class CommentModel extends CommentEntity {
  final String? commentId;
  final String? postId;
  final String? creatorUid;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createAt;
  final List<String>? likes;
  final num? totalReply;

  CommentModel({
    this.commentId,
    this.postId,
    this.creatorUid,
    this.description,
    this.username,
    this.userProfileUrl,
    this.createAt,
    this.likes,
    this.totalReply,
  }) : super(
          postId: postId,
          creatorUid: creatorUid,
          description: description,
          userProfileUrl: userProfileUrl,
          username: username,
          likes: likes,
          createAt: createAt,
          commentId: commentId,
          totalReply: totalReply,
        );

  factory CommentModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CommentModel(
      postId: snapshot['postId'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      userProfileUrl: snapshot['userProfileUrl'],
      commentId: snapshot['commentId'],
      createAt: snapshot['createAt'],
      totalReply: snapshot['totalReplays'],
      username: snapshot['username'],
      likes: List.from(snap.get("likes")),
    );
  }

  Map<String, dynamic> toJson() => {
        "creatorUid": creatorUid,
        "description": description,
        "userProfileUrl": userProfileUrl,
        "commentId": commentId,
        "createAt": createAt,
        "totalReplays": totalReply,
        "postId": postId,
        "likes": likes,
        "username": username,
      };
}
