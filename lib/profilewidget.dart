import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

Widget profileWidget({String? imageUrl, File? image}) {
  if (image == null) {
    if (imageUrl == null || imageUrl == "") {
      return Image.asset(
        'assets/profile.png',
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: "$imageUrl",
        height: 50,
        width: 50,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return CircularProgressIndicator();
        },
      );
    }
  } else {
    return Image.file(
      image,
      fit: BoxFit.cover,
    );
  }
}
