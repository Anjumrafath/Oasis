import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/postcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/widget/updatepostmainwidget.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;

class UpdatePostPage extends StatelessWidget {
  final PostEntity post;
  const UpdatePostPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context) => di.sl<PostCubit>(),
      child: UpdatePostMainWidget(post: post),
    );
  }
}
