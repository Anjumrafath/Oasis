import 'package:flutter/material.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/reply/replyentity.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/getcurrentuidusecase.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;
import 'package:insta_cleanarchitecture/profilewidget.dart';
import 'package:intl/intl.dart';

class SingleReplayWidget extends StatefulWidget {
  final ReplayEntity replay;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikeClickListener;
  const SingleReplayWidget(
      {Key? key,
      required this.replay,
      this.onLongPressListener,
      this.onLikeClickListener})
      : super(key: key);

  @override
  State<SingleReplayWidget> createState() => _SingleReplayWidgetState();
}

class _SingleReplayWidgetState extends State<SingleReplayWidget> {
  String _currentUid = "";

  @override
  void initState() {
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.replay.creatorUid == _currentUid
          ? widget.onLongPressListener
          : null,
      child: Container(
        margin: EdgeInsets.only(left: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: profileWidget(imageUrl: widget.replay.userProfileUrl),
              ),
            ),
            sizeHor(10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.replay.username}",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        GestureDetector(
                            onTap: widget.onLikeClickListener,
                            child: Icon(
                              widget.replay.likes!.contains(_currentUid)
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              size: 20,
                              color: widget.replay.likes!.contains(_currentUid)
                                  ? Colors.red
                                  : Colors.grey,
                            ))
                      ],
                    ),
                    sizeVer(4),
                    Text(
                      "${widget.replay.description}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    sizeVer(4),
                    Text(
                      "${DateFormat("dd/MMM/yyy").format(widget.replay.createAt!.toDate())}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
