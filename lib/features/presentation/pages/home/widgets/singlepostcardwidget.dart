import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/appentity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/getcurrentuidusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/postcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/comment/commentpage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/updatepostpage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/widget/likeanimationwidget.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/singleuserprofilepage.dart';
import 'package:insta_cleanarchitecture/profilewidget.dart';
import 'package:intl/intl.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;

class SinglePostCardWidget extends StatefulWidget {
  final PostEntity post;
  const SinglePostCardWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<SinglePostCardWidget> createState() => _SinglePostCardWidgetState();
}

class _SinglePostCardWidgetState extends State<SinglePostCardWidget> {
  String _currentUid = "";

  @override
  void initState() {
    // Retrieve an instance of GetCurrentUidUseCase using dependency injection (DI),
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }

  bool _isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageConst.singleUserProfilePage,
                      arguments: widget.post.creatorUid);
                },
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: profileWidget(
                            imageUrl: "${widget.post.userProfileUrl}"),
                      ),
                    ),
                    sizeHor(10),
                    Text(
                      "${widget.post.username}",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              widget.post.creatorUid == _currentUid
                  ? GestureDetector(
                      onTap: () {
                        _openBottomModalSheet(context, widget.post);
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ))
                  : Container(
                      width: 0,
                      height: 0,
                    )
            ],
          ),
          sizeVer(10),
          GestureDetector(
            onDoubleTap: () {
              _likePost();
              setState(() {
                _isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: profileWidget(imageUrl: "${widget.post.postImageUrl}"),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: _isLikeAnimating ? 1 : 0,
                  child: LikeAnimationWidget(
                      duration: Duration(milliseconds: 200),
                      isLikeAnimating: _isLikeAnimating,
                      onLikeFinish: () {
                        setState(() {
                          _isLikeAnimating = false;
                        });
                      },
                      child: Icon(
                        Icons.favorite,
                        size: 100,
                        color: Colors.blueGrey,
                      )),
                ),
              ],
            ),
          ),
          sizeVer(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: _likePost,
                      child: Icon(
                        widget.post.likes!.contains(_currentUid)
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: widget.post.likes!.contains(_currentUid)
                            ? Colors.red
                            : Colors.blueGrey,
                      )),
                  sizeHor(10),
                  GestureDetector(
                      onTap: () {
                        //  Navigator.pushNamed(context, PageConst.commentPage,
                        //     arguments: AppEntity(
                        //        uid: _currentUid, postId: widget.post.postId));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentPage(
                                      appEntity: AppEntity(
                                          postId: widget.post.postId,
                                          uid: _currentUid),
                                    )));
                      },
                      child: Icon(
                        Icons.add_box_rounded,
                        color: Colors.blueGrey,
                      )),
                  sizeHor(10),
                  Icon(
                    Icons.message_sharp,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
              Icon(
                Icons.bookmark_border,
                color: Colors.blueGrey,
              )
            ],
          ),
          sizeVer(10),
          Text(
            "${widget.post.totalLikes} likes",
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
          sizeVer(10),
          Row(
            children: [
              Text(
                "${widget.post.username}",
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
              sizeHor(10),
              Text(
                "${widget.post.description}",
                style: TextStyle(color: Colors.blueGrey),
              ),
            ],
          ),
          sizeVer(10),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageConst.commentPage,
                    arguments: AppEntity(
                        uid: _currentUid, postId: widget.post.postId));
              },
              child: Text(
                "View all ${widget.post.totalComments} comments",
                style: TextStyle(color: Colors.grey),
              )),
          sizeVer(10),
          Text(
            "${DateFormat("dd/MMM/yyy").format(widget.post.createAt!.toDate())}",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  _openBottomModalSheet(BuildContext context, PostEntity post) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(color: Colors.white.withOpacity(.8)),
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
                            color: Colors.blueGrey),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: _deletePost,
                        child: Text(
                          "Delete Post",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.blueGrey),
                        ),
                      ),
                    ),
                    sizeVer(7),
                    Divider(
                      thickness: 1,
                      color: Colors.blue,
                    ),
                    sizeVer(7),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          //  Navigator.pushNamed(context, PageConst.updatePostPage,
                          //      arguments: post);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdatePostPage(
                                        post: post,
                                      )));
                        },
                        child: Text(
                          "Update Post",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.blueGrey),
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

//BlocProvider.of<PostCubit>(context) retrieves the instance of the PostCubit from the nearest ancestor BlocProvider widget in the widget tree.
  _deletePost() {
    BlocProvider.of<PostCubit>(context)
        .deletePost(post: PostEntity(postId: widget.post.postId));
  }

  _likePost() {
    BlocProvider.of<PostCubit>(context)
        .likePost(post: PostEntity(postId: widget.post.postId));
  }
}
