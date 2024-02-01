import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';

class PostModel extends PostEntity {
  final String? postId;
  final String? createUid;
  final String? username;
  final String? description;
  final String? postImageUrl;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createAt;
  final String? userProfileUrl;

  PostModel(
      {this.postId,
      this.createUid,
      this.username,
      this.description,
      this.postImageUrl,
      this.likes,
      this.totalLikes,
      this.totalComments,
      this.createAt,
      this.userProfileUrl})
      : super(
          postId: postId,
          createUid: createUid,
          username: username,
          description: description,
          postImageUrl: postImageUrl,
          likes: likes,
          totalLikes: totalLikes,
          totalComments: totalComments,
          createAt: createAt,
          userProfileUrl: userProfileUrl,
        );

  factory PostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      postId: snapshot['postId'],
      createUid: snapshot['createUid'],
      username: snapshot['username'],
      description: snapshot['description'],
      postImageUrl: snapshot['postImageUrl'],
      likes: snapshot['likes'],
      totalLikes: snapshot['totalLikes'],
      totalComments: snapshot['totalComments'],
      createAt: snapshot['createAt'],
      userProfileUrl: snapshot['userprofileUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "createUid": createUid,
        "username": username,
        "description": description,
        "postImageUrl": postImageUrl,
        "likes": likes,
        "totalLikes": totalLikes,
        "totalComments": totalComments,
        "createAt": createAt,
        "userProfileUrl": userProfileUrl,
      };
}
