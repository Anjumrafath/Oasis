import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/reply/replyentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/replay/replaycubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/widget/profileformwidget.dart';
import 'package:insta_cleanarchitecture/features/presentation/widgets/buttoncontainerwidget.dart';

class EditReplayMainWidget extends StatefulWidget {
  final ReplayEntity replay;
  const EditReplayMainWidget({Key? key, required this.replay})
      : super(key: key);

  @override
  State<EditReplayMainWidget> createState() => _EditReplayMainWidgetState();
}

class _EditReplayMainWidgetState extends State<EditReplayMainWidget> {
  TextEditingController? _descriptionController;

  bool _isReplayUpdating = false;

  @override
  void initState() {
    _descriptionController =
        TextEditingController(text: widget.replay.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        // backgroundColor: Colors.red,
        title: Text(
          "Edit Replay",
          selectionColor: Colors.blueGrey,
        ),
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
                _editReplay();
              },
            ),
            sizeVer(10),
            _isReplayUpdating == true
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

  _editReplay() {
    setState(() {
      _isReplayUpdating = true;
    });
    BlocProvider.of<ReplayCubit>(context)
        .updateReplay(
            replay: ReplayEntity(
                postId: widget.replay.postId,
                commentId: widget.replay.commentId,
                replayId: widget.replay.replayId,
                description: _descriptionController!.text))
        .then((value) {
      setState(() {
        _isReplayUpdating = false;
        _descriptionController!.clear();
      });
      Navigator.pop(context);
    });
  }
}
