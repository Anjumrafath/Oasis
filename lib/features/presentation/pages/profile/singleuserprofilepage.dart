import 'package:insta_cleanarchitecture/features/presentation/pages/profile/widget/singleuserprofilemainwidget.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/postcubit.dart';

class SingleUserProfilePage extends StatelessWidget {
  final String otherUserId;

  const SingleUserProfilePage({Key? key, required this.otherUserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCubit>(
          create: (context) => di.sl<PostCubit>(),
        ),
      ],
      child: SingleUserProfileMainWidget(otherUserId: otherUserId),
    );
  }
}
