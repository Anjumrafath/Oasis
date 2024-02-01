import 'package:flutter/material.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/comment/commentpage.dart';
import 'package:insta_cleanarchitecture/profilewidget.dart';
import 'package:intl/intl.dart';

class SinglePostCardWidget extends StatelessWidget {
  final PostEntity post;
  const SinglePostCardWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: secondaryColor, shape: BoxShape.circle),
                ),
                sizeHor(10),
                Text(
                  "username",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: primaryColor),
                )
              ]),
              GestureDetector(
                  onTap: () {
                    _openBottomModelSheet(context);
                  },
                  child: Icon(Icons.more_vert, color: primaryColor))
            ],
          ),
          sizeVer(10),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            color: secondaryColor,
            //child: profileWidget(imageUrl: "${post.postImageUrl}"),
          ),
          sizeVer(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite, color: primaryColor),
                  sizeHor(10),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentPage()));
                        //  Navigator.pushNamed(context, PageConst.commentPage);
                      },
                      child: Icon(Icons.add_box_rounded, color: primaryColor)),
                  sizeHor(10),
                  Icon(Icons.message_sharp, color: primaryColor),
                ],
              ),
              Icon(Icons.bookmark, color: primaryColor),
            ],
          ),
          sizeVer(10),
          Text(
            "likes",
            style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
          ),
          sizeVer(10),
          Row(
            children: [
              Text(
                "username",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
              ),
              sizeHor(10),
              Text(
                "description",
                style: TextStyle(color: primaryColor),
              )
            ],
          ),
          sizeVer(10),
          Text(
            "View all  comments",
            style: TextStyle(color: Colors.blueGrey),
          ),
          sizeVer(10),
          Text(
            "16/1/24",
            style: TextStyle(color: Colors.blueGrey),
          )
        ],
      ),
    );
  }

  _openBottomModelSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(color: backGroundColor.withOpacity(0.8)),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //    context,
                          //    MaterialPageRoute(
                          //        builder: (context) => UpdatePostPage()));
                          Navigator.pushNamed(
                              context, PageConst.updatePostPage);
                        },
                        child: Text(
                          "Update Post",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 1,
                      color: secondaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        child: Text(
                          "Delete Post",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
