import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/firebaseusecases/storage/uploadimagetostorageusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/postcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/widget/profileformwidget.dart';
import 'package:insta_cleanarchitecture/profilewidget.dart';
import 'package:uuid/uuid.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;
import 'package:shimmer/shimmer.dart';

class UploadPostMainWidget extends StatefulWidget {
  final UserEntity currentUser;
  const UploadPostMainWidget({
    super.key,
    required this.currentUser,
  });

  @override
  State<UploadPostMainWidget> createState() => _UploadPostMainWidgetState();
}

class _UploadPostMainWidgetState extends State<UploadPostMainWidget> {
  File? _image;
  TextEditingController _descriptionController = TextEditingController();
  bool _uploading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return _image == null
        ? _uploadPostWidget()
        : Scaffold(
            // backgroundColor: Colors.red,
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () => setState(
                        () => _image = null,
                      ),
                  child: Icon(Icons.close, size: 28)),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: _submitPost, child: Icon(Icons.arrow_forward)),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: profileWidget(
                            imageUrl: "${widget.currentUser.profileUrl}")),
                  ),
                  sizeVer(10),
                  Text(
                    "${widget.currentUser.username}",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  sizeVer(10),
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: profileWidget(image: _image),
                  ),
                  sizeVer(10),
                  ProfileFormWidget(
                    title: "Description",
                    controller: _descriptionController,
                  ),
                  sizeVer(10),
                  _uploading == true
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Uploading...",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 173, 78, 78)),
                              ),
                              sizeHor(10),
                              //   CircularProgressIndicator(),
                            ],
                          ),
                        )
                      : Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                        ),
                ],
              ),
            ),
          );
  }

  _submitPost() {
    setState(() {
      _uploading = true;
    });
    di
        .sl<UploadImageToStorageUseCase>()
        .call(_image!, true, "posts")
        .then((imageUrl) {
      _createSubmitPost(image: imageUrl);
    });
  }

  _createSubmitPost({required String image}) {
    BlocProvider.of<PostCubit>(context)
        .createPost(
            post: PostEntity(
          postId: Uuid().v1(),
          creatorUid: widget.currentUser.uid,
          username: widget.currentUser.username,
          description: _descriptionController.text,
          postImageUrl: image,
          likes: [],
          totalLikes: 0,
          totalComments: 0,
          createAt: Timestamp.now(),
          userProfileUrl: widget.currentUser.profileUrl,
        ))
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _uploading = false;
      _descriptionController.clear();
      _image = null;
    });
  }

  _uploadPostWidget() {
    return Scaffold(
      //  backgroundColor: Colors.red,
      body: Center(
        child: GestureDetector(
          onTap: selectImage,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.upload,
                color: Colors.blueGrey,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
