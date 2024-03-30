import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/postcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/poststate.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/chat/chatscreen.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/home/widgets/singlepostcardwidget.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _isDarkMode = false;
  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = isDarkMode;
      prefs.setBool('isDarkMode', isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Toggle',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        // backgroundColor: Colors.red,
        appBar: AppBar(
          //  backgroundColor: Colors.red,
          title: Image.asset(
            "assets/logo.png",
            width: 150,
            height: 150,
          ),
          actions: [
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                _toggleTheme(value);
              },
            ),
            // ThemedButton(),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                icon: Icon(
                  Icons.chat,
                )),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.messenger_outline,
              ),
            )
          ],
        ),

        // The cubit is initialized with a PostEntity and retrieves posts upon creation.
        body: BlocProvider<PostCubit>(
          create: (context) => di.sl<PostCubit>()..getPosts(post: PostEntity()),
          child: BlocBuilder<PostCubit, PostState>(
            builder: (context, postState) {
              if (postState is PostLoading) {
                return Center(
                    child: Container(
                        height: 800,
                        width: double.infinity,
                        child: Shimmer.fromColors(
                          direction: ShimmerDirection.ttb,
                          child: ListView.builder(
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(20),
                                  height: 200,
                                  width: 300,
                                  color: Colors.blueGrey,
                                );
                              }),
                          baseColor: Colors.blueGrey,
                          highlightColor: Colors.blueGrey,
                        ))
                    // child: CircularProgressIndicator(),
                    );
                // child: CircularProgressIndicator(),
              }
              if (postState is PostFailure) {
                toast("Some Failure occured while creating the post");
              }
              //   display either a widget indicating no posts if the list is empty,
              // or render a ListView with post items, each wrapped in a BlocProvider
              if (postState is PostLoaded) {
                return postState.posts.isEmpty
                    ? _noPostsYetWidget()
                    : ListView.builder(
                        itemCount: postState.posts.length,
                        itemBuilder: (context, index) {
                          final post = postState.posts[index];
                          return BlocProvider(
                            create: (context) => di.sl<PostCubit>(),
                            child: SinglePostCardWidget(post: post),
                          );
                        },
                      );
              }

              return Center(
                  child: Container(
                      height: 800,
                      width: double.infinity,
                      child: Shimmer.fromColors(
                        direction: ShimmerDirection.ttb,
                        child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(20),
                                height: 200,
                                width: 300,
                                color: Colors.blueGrey,
                              );
                            }),
                        baseColor: Colors.blueGrey,
                        highlightColor: Colors.blueGrey,
                      ))
                  // child: CircularProgressIndicator(),
                  );
            },
          ),
        ),
      ),
    );
  }

  _noPostsYetWidget() {
    return Center(
      child: Text(
        "No Posts Yet",
        style: TextStyle(
            color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
