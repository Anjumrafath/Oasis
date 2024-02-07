import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import "package:insta_cleanarchitecture/const.dart";
//import 'package:cloneinstagram/features/presentation/page/profile/widget/profileformwidget.dart';
import 'package:flutter/material.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/firebaseusecases/storage/uploadimagetostorageusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/postcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/widget/profileformwidget.dart';
import 'package:insta_cleanarchitecture/profilewidget.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;

class UpdatePostMainWidget extends StatefulWidget {
  final PostEntity post;
  const UpdatePostMainWidget({super.key, required this.post});

  @override
  State<UpdatePostMainWidget> createState() => _UpdatePostMainWidget();
}

class _UpdatePostMainWidget extends State<UpdatePostMainWidget> {
  TextEditingController? _descriptionController;
  @override
  void dispose() {
    _descriptionController!.dispose();
    super.dispose();
  }

  File? _image;
  bool? _uploading = false;
  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.camera);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  void initState() {
    _descriptionController =
        TextEditingController(text: widget.post.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Text("Edit Post"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
                onTap: _updatePost,
                child: Icon(Icons.done, color: blueColor, size: 25)),
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
              // decoration: BoxDecoration(
              // shape: BoxShape.circle,
              //color: secondaryColor,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: profileWidget(imageUrl: widget.post.userProfileUrl)),
            ),
            sizeVer(10),
            Text(
              "${widget.post.username}",
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            sizeVer(10),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  // decoration: BoxDecoration(color: secondaryColor),
                  child: profileWidget(
                      imageUrl: widget.post.postImageUrl, image: _image),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: GestureDetector(
                    onTap: selectImage,
                    child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.edit,
                          color: blueColor,
                        )),
                  ),
                ),
              ],
            ),
            sizeVer(10),
            ProfileFormWidget(
                controller: _descriptionController, title: "Description"),
            sizeVer(10),
            _uploading == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Updating...",
                        style: TextStyle(color: Colors.white),
                      ),
                      sizeHor(10),
                      CircularProgressIndicator(),
                    ],
                  )
                : Container(width: 0, height: 0)
          ],
        ),
      ),
    );
  }

  _updatePost() {
    setState(() {
      _uploading = true;
    });
    if (_image == null) {
      _submitUpdatePost(image: widget.post.postImageUrl!);
    } else {
      di
          .sl<UploadImageToStorageUseCase>()
          .call(_image!, true, "post")
          .then((imageUrl) {
        _submitUpdatePost(image: imageUrl);
      });
    }
  }

  _submitUpdatePost({required String image}) {
    BlocProvider.of<PostCubit>(context)
        .updatePost(
          post: PostEntity(
              createUid: widget.post.createUid,
              postId: widget.post.postId,
              postImageUrl: image,
              description: _descriptionController!.text),
        )
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _image = null;
      _descriptionController!.clear();
      Navigator.pop(context);
      _uploading = false;
    });
  }
}
