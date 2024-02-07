import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/comment/commententity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/comment/commentcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/comment/widget/editcommentmainwidget.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;

class EditCommentPage extends StatelessWidget {
  final CommentEntity comment;

  const EditCommentPage({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentCubit>(
      create: (context) => di.sl<CommentCubit>(),
      child: EditCommentMainWidget(comment: comment),
    );
  }
}
