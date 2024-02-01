import 'package:flutter/material.dart';
import 'package:insta_cleanarchitecture/const.dart';

import '../../../widgets/formcontainerwidget.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  bool _isUserReplying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
        title: Text("Comments"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    sizeHor(10),
                    Text("Username",
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
                    "This place is awesome!",
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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  sizeHor(10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizeHor(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Username",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                      color: primaryColor)),
                              Icon(
                                Icons.favorite_outline,
                                size: 20,
                                color: primaryColor,
                              )
                            ],
                          ),
                          sizeVer(4),
                          Text(
                            "This is comment",
                            style: TextStyle(color: primaryColor),
                          ),
                          sizeVer(4),
                          Row(
                            children: [
                              Text(
                                "17/1/24",
                                style: TextStyle(
                                    color: darkGreyColor, fontSize: 12),
                              ),
                              sizeHor(10),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isUserReplying = !_isUserReplying;
                                  });
                                },
                                child: Text(
                                  "Reply",
                                  style: TextStyle(
                                      color: darkGreyColor, fontSize: 12),
                                ),
                              ),
                              sizeHor(10),
                              Text(
                                "View Replies",
                                style: TextStyle(
                                    color: darkGreyColor, fontSize: 12),
                              ),
                            ],
                          ),
                          _isUserReplying == true ? sizeVer(10) : sizeVer(0),
                          _isUserReplying == true
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    FormContainerWidget(
                                        hintText: "Post your reply..."),
                                    sizeVer(10),
                                    Text(
                                      "Post",
                                      style: TextStyle(color: blueColor),
                                    )
                                  ],
                                )
                              : Container(width: 0, height: 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _commentSection()
        ],
      ),
    );
  }

  _commentSection() {
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
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(20)),
            ),
            sizeHor(10),
            Expanded(
                child: TextFormField(
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                  hintText: "Post your comment...",
                  hintStyle: TextStyle(color: Colors.black)),
            )),
            Text(
              "Post",
              style: TextStyle(fontSize: 15, color: blueColor),
            )
          ],
        ),
      ),
    );
  }
}
