import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/appentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/comment/commentcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/getsinglepost/getsinglepostcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/getsingleuser/getsingleusercubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/comment/widget/commentmainwidget.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;

class CommentPage extends StatelessWidget {
  final AppEntity appEntity;
  const CommentPage({super.key, required this.appEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommentCubit>(
          create: (context) => di.sl<CommentCubit>(),
        ),
        BlocProvider<GetSingleUserCubit>(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider<GetSinglePostCubit>(
          create: (context) => di.sl<GetSinglePostCubit>(),
        ),
      ],
      child: CommentMainWidget(appEntity: appEntity),
    );
  }
}
