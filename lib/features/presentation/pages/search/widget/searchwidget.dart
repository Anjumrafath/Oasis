import 'package:flutter/material.dart';
import 'package:insta_cleanarchitecture/const.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  const SearchWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.blueGrey),
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blueGrey,
            ),
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
      ),
    );
  }
}
