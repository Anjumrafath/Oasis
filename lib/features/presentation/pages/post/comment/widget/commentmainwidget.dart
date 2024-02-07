import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/appentity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/comment/commententity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/comment/commentcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/comment/commentstate.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/getsinglepost/getsinglepostcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/getsinglepost/getsinglepoststate.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/replay/replaycubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/getsingleuser/getsingleusercubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/getsingleuser/getsingleuserstate.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/comment/widget/singlecommentwidget.dart';
import 'package:insta_cleanarchitecture/profilewidget.dart';
import 'package:uuid/uuid.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;

class CommentMainWidget extends StatefulWidget {
  final AppEntity appEntity;

  const CommentMainWidget({super.key, required this.appEntity});

  @override
  State<CommentMainWidget> createState() => _CommentMainWidgetState();
}

class _CommentMainWidgetState extends State<CommentMainWidget> {
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context)
        .getSingleUser(uid: widget.appEntity.uid!);
    BlocProvider.of<GetSinglePostCubit>(context)
        .getSinglePost(postId: widget.appEntity.postId!);
    BlocProvider.of<CommentCubit>(context)
        .getComments(postId: widget.appEntity.postId!);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
        title: Text("Comments"),
      ),
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, singleUserState) {
          if (singleUserState is GetSingleUserLoaded) {
            final singleUser = singleUserState.user;
            return BlocBuilder<GetSinglePostCubit, GetSinglePostState>(
              builder: (context, singlePostState) {
                if (singlePostState is GetSinglePostLoaded) {
                  final singlePost = singlePostState.post;
                  return BlocBuilder<CommentCubit, CommentState>(
                    builder: (context, commentState) {
                      if (commentState is CommentLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: profileWidget(
                                              imageUrl:
                                                  singlePost.userProfileUrl),
                                        ),
                                      ),
                                      sizeHor(10),
                                      Text("${singlePost.username}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w200,
                                              color: primaryColor)),
                                    ],
                                  ),
                                  sizeVer(10),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 200),
                                    child: Text(
                                      "${singlePost.description}",
                                      style: TextStyle(color: primaryColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            sizeVer(10),
                            Divider(
                              color: secondaryColor,
                            ),
                            sizeVer(10),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: commentState.comments.length,
                                  itemBuilder: (context, index) {
                                    final singleComment =
                                        commentState.comments[index];
                                    return BlocProvider(
                                      create: (context) => di.sl<ReplayCubit>(),
                                      child: SingleCommentWidget(
                                        currentUser: singleUser,
                                        comment: singleComment,
                                        onLongPressListener: () {
                                          _openBottomModalSheet(
                                              context: context,
                                              comment:
                                                  commentState.comments[index]);
                                        },
                                        onLikeClickListener: () {
                                          _likeComment(
                                              comment:
                                                  commentState.comments[index]);
                                        },
                                      ),
                                    );
                                  }),
                            ),
                            _commentSection(currentUser: singleUser)
                          ],
                        );
                      }

                      return Center(child: CircularProgressIndicator());
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _commentSection({required UserEntity currentUser}) {
    return Container(
      width: double.infinity,
      height: 55,
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: profileWidget(imageUrl: currentUser.profileUrl)),
            ),
            sizeHor(10),
            Expanded(
                child: TextFormField(
              controller: _descriptionController,
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                  hintText: "Post your comment...",
                  hintStyle: TextStyle(color: Colors.black)),
            )),
            GestureDetector(
              onTap: _createComment(currentUser),
              child: Text(
                "post",
                style: TextStyle(fontSize: 15, color: blueColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  _createComment(UserEntity currentUser) {
    BlocProvider.of<CommentCubit>(context)
        .createComment(
            comment: CommentEntity(
      totalReply: 0,
      commentId: Uuid().v1(),
      createAt: Timestamp.now(),
      likes: [],
      username: currentUser.username,
      userProfileUrl: currentUser.profileUrl,
      description: _descriptionController.text,
      creatorUid: currentUser.uid,
      postId: widget.appEntity.postId,
    ))
        .then((then) {
      setState(() {
        _descriptionController.clear();
      });
    });
  }

  _openBottomModalSheet(
      {required BuildContext context, required CommentEntity comment}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(color: backGroundColor.withOpacity(.8)),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "More Options",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: primaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 1,
                      color: secondaryColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          _deleteComment(
                              commentId: comment.commentId!,
                              postId: comment.postId!);
                        },
                        child: Text(
                          "Delete Comment",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: primaryColor),
                        ),
                      ),
                    ),
                    sizeVer(7),
                    Divider(
                      thickness: 1,
                      color: secondaryColor,
                    ),
                    sizeVer(7),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, PageConst.updatePostPage,
                              arguments: comment);
//
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                        },
                        child: Text(
                          "Update Comment",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: primaryColor),
                        ),
                      ),
                    ),
                    sizeVer(7),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _deleteComment({required String commentId, required String postId}) {
    BlocProvider.of<CommentCubit>(context).deleteComment(
        comment: CommentEntity(commentId: commentId, postId: postId));
  }

  _likeComment({required CommentEntity comment}) {
    BlocProvider.of<CommentCubit>(context).likeComment(
        comment: CommentEntity(
            commentId: comment.commentId, postId: comment.postId));
  }
}
