import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/comment/commententity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/comment/commentcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/widget/profileformwidget.dart';
import 'package:insta_cleanarchitecture/features/presentation/widgets/buttoncontainerwidget.dart';

class EditCommentMainWidget extends StatefulWidget {
  final CommentEntity comment;
  const EditCommentMainWidget({Key? key, required this.comment})
      : super(key: key);

  @override
  State<EditCommentMainWidget> createState() => _EditCommentMainWidgetState();
}

class _EditCommentMainWidgetState extends State<EditCommentMainWidget> {
  TextEditingController? _descriptionController;

  bool _isCommentUpdating = false;

  @override
  void initState() {
    _descriptionController =
        TextEditingController(text: widget.comment.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        //  backgroundColor: Colors.red,
        title: Text("Edit Comment"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            ProfileFormWidget(
              title: "description",
              controller: _descriptionController,
            ),
            sizeVer(10),
            ButtonContainerWidget(
              color: Colors.blue,
              text: "Save Changes",
              onTapListener: () {
                _editComment();
              },
            ),
            sizeVer(10),
            _isCommentUpdating == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Updating...",
                        style: TextStyle(color: Colors.red),
                      ),
                      sizeHor(10),
                      CircularProgressIndicator(),
                    ],
                  )
                : Container(
                    width: 0,
                    height: 0,
                  )
          ],
        ),
      ),
    );
  }

  _editComment() {
    setState(() {
      _isCommentUpdating = true;
    });
    BlocProvider.of<CommentCubit>(context)
        .updateComment(
            comment: CommentEntity(
                postId: widget.comment.postId,
                commentId: widget.comment.commentId,
                description: _descriptionController!.text))
        .then((value) {
      setState(() {
        _isCommentUpdating = false;
        _descriptionController!.clear();
      });
      Navigator.pop(context);
    });
  }
}
