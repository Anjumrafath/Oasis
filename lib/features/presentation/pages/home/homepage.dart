import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_cleanarchitecture/const.dart';

import 'package:flutter/material.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/postcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/poststate.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/home/widgets/singlepostcardwidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/widget/uploadpostmainwidget.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;
import 'package:uuid/uuid.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Image.asset(
          "assets/logo.png",
          width: 200,
          height: 150,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.messenger_outline,
            ),
          )
        ],
      ),
      body: BlocProvider<PostCubit>(
        create: (context) => di.sl<PostCubit>()..getPosts(post: PostEntity()),
        child: BlocBuilder<PostCubit, PostState>(builder: (context, postState) {
          if (postState is PostLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (postState is PostFailure) {
            toast("some failure occured while creating the post");
          }
          if (postState is PostLoaded) {
            return ListView.builder(
                itemCount: postState.posts.length,
                itemBuilder: (context, index) {
                  final post = postState.posts[index];
                  return SinglePostCardWidget(post: post);
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
