import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/postcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/widget/uploadpostmainwidget.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;

class UploadPostPage extends StatelessWidget {
  final UserEntity currentUser;
  const UploadPostPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context) => di.sl<PostCubit>(),
      child: UploadPostMainWidget(currentUser: currentUser),
    );
  }
}
