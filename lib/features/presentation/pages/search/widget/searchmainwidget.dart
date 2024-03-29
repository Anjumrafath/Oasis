import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/postcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/poststate.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/usercubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/userstate.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/search/widget/searchwidget.dart';
import 'package:insta_cleanarchitecture/profilewidget.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/postdetailpage.dart';
import 'package:shimmer/shimmer.dart';

class SearchMainWidget extends StatefulWidget {
  const SearchMainWidget({Key? key}) : super(key: key);

  @override
  State<SearchMainWidget> createState() => _SearchMainWidgetState();
}

class _SearchMainWidgetState extends State<SearchMainWidget> {
  TextEditingController _searchController = TextEditingController();

// Using BlocProvider to access the UserCubit and retrieve users data
// Using BlocProvider to access the PostCubit and retrieve posts data
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers(user: UserEntity());
    BlocProvider.of<PostCubit>(context).getPosts(post: PostEntity());
    super.initState();

    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.red,
        // this below section using BlocBuilder to build UI based on UserCubit state
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            if (userState is UserLoaded) {
              final filterAllUsers = userState.users
                  .where((user) =>
                      user.username!.startsWith(_searchController.text) ||
                      user.username!
                          .toLowerCase()
                          .startsWith(_searchController.text.toLowerCase()) ||
                      user.username!.contains(_searchController.text) ||
                      user.username!
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()))
                  .toList();
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchWidget(
                      controller: _searchController,
                    ),
                    sizeVer(10),
                    _searchController.text.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: filterAllUsers.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          PageConst.singleUserProfilePage,
                                          arguments: filterAllUsers[index].uid);
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: 40,
                                          height: 40,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: profileWidget(
                                                imageUrl: filterAllUsers[index]
                                                    .profileUrl),
                                          ),
                                        ),
                                        sizeHor(10),
                                        Text(
                                          "${filterAllUsers[index].username}",
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : BlocBuilder<PostCubit, PostState>(
                            builder: (context, postState) {
                              if (postState is PostLoaded) {
                                final posts = postState.posts;
                                return Expanded(
                                  child: GridView.builder(
                                      itemCount: posts.length,
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                PageConst.postDetailPage,
                                                arguments: posts[index].postId);
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            child: profileWidget(
                                                imageUrl:
                                                    posts[index].postImageUrl),
                                          ),
                                        );
                                      }),
                                );
                              }

                              return Center(
                                  child: Container(
                                      height: 800,
                                      width: double.infinity,
                                      child: Shimmer.fromColors(
                                        direction: ShimmerDirection.ttb,
                                        child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: EdgeInsets.all(10),
                                                height: 100,
                                                width: 100,
                                                color: Colors.blueGrey,
                                              );
                                            }),
                                        baseColor: Colors.blueGrey,
                                        highlightColor: Colors.blueGrey,
                                      ))
                                  // child: CircularProgressIndicator(),
                                  );
                            },
                          )
                  ],
                ),
              );
            }

            return Center(
                child: Container(
                    height: 800,
                    width: double.infinity,
                    child: Shimmer.fromColors(
                      direction: ShimmerDirection.ttb,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              height: 100,
                              width: 100,
                              color: Colors.blueGrey,
                            );
                          }),
                      baseColor: Colors.blueGrey,
                      highlightColor: Colors.blueGrey,
                    ))
                // child: CircularProgressIndicator(),
                );
            //  child: CircularProgressIndicator(),
          },
        ),
      ),
    );
  }
}
