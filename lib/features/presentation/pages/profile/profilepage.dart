import 'package:insta_cleanarchitecture/injection container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/postcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/widget/profilemainwidget.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity currentUser;

  const ProfilePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<PostCubit>(),
      child: ProfileMainWidget(
        currentUser: currentUser,
      ),
    );
  }
}
