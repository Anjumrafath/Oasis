import 'package:insta_cleanarchitecture/const.dart';
import 'package:flutter/material.dart';

class ProfileFormWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  const ProfileFormWidget({super.key, this.title, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(color: Colors.blueGrey, fontSize: 16),
        ),
        sizeVer(10),
        TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.blueGrey),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelStyle: TextStyle(color: Colors.blueGrey),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.blue,
        ),
      ],
    );
  }
}
