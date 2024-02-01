import "package:insta_cleanarchitecture/const.dart";
//import 'package:cloneinstagram/features/presentation/page/profile/widget/profileformwidget.dart';
import 'package:flutter/material.dart';

import '../profile/widget/profileformwidget.dart';

class UpdatePostPage extends StatelessWidget {
  const UpdatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Text("Edit Post"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.done, color: blueColor, size: 25),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            sizeVer(10),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryColor,
              ),
            ),
            sizeVer(10),
            Text(
              "Username",
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            sizeVer(10),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(color: secondaryColor),
            ),
            sizeVer(10),
            ProfileFormWidget(title: "Description"),
          ],
        ),
      ),
    );
  }
}
