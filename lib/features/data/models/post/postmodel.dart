import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';

class PostModel extends PostEntity {
  final String? postId;
  final String? creatorUid;
  final String? username;
  final String? description;
  final String? postImageUrl;
  late List? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createAt;
  final String? userProfileUrl;

  PostModel(
      {this.postId,
      this.creatorUid,
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
          creatorUid: creatorUid,
          username: username,
          description: description,
          postImageUrl: postImageUrl,
          likes: likes,
          totalLikes: totalLikes,
          totalComments: totalComments,
          createAt: createAt,
          userProfileUrl: userProfileUrl,
        );
// Factory method to create a postModel object from a DocumentSnapshot.
  factory PostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      postId: snapshot['postId'],
      creatorUid: snapshot['creatorUid'],
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
// Converts the postModel object to a JSON format.
  Map<String, dynamic> toJson() => {
        "postId": postId,
        "creatorUid": creatorUid,
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
