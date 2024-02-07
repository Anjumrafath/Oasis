import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/reply/replyentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/replay/replaycubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/comment/widget/editreplaymainwidget.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;

class EditReplayPage extends StatelessWidget {
  final ReplayEntity replay;

  const EditReplayPage({Key? key, required this.replay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReplayCubit>(
      create: (context) => di.sl<ReplayCubit>(),
      child: EditReplayMainWidget(replay: replay),
    );
  }
}
