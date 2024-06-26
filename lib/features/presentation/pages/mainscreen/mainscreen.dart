import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/getsingleuser/getsingleusercubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/getsingleuser/getsingleuserstate.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/activity/activitypage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/home/homepage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/post/uploadpostpage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/profilepage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/search/searchpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  const MainScreen({super.key, required this.uid});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late bool _isDarkMode = false;
  int _currentIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    pageController = PageController(initialPage: _currentIndex);
    _loadTheme();
    // pageController = PageController();

    super.initState();
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
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserState) {
        if (getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.user;

          return MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: Scaffold(
              appBar: AppBar(
                actions: [
                  Switch(
                    value: _isDarkMode,
                    onChanged: (value) {
                      _toggleTheme(value);
                    },
                  ),
                ],
              ),
              // backgroundColor: Colors.red,
              bottomNavigationBar: BottomNavigationBar(
                //  backgroundColor: Colors.red,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home, color: Colors.blueGrey),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search, color: Colors.blueGrey),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.blueGrey,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.blueGrey,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined,
                        color: Colors.blueGrey),
                    label: '',
                  ),
                ],
                onTap: navigationTapped,
              ),
              body: PageView(
                controller: pageController,
                children: [
                  HomePage(),
                  SearchPage(),
                  UploadPostPage(
                    currentUser: currentUser,
                  ),
                  ActivityPage(),
                  ProfilePage(
                    currentUser: currentUser,
                  ),
                ],
                onPageChanged: onPageChanged,
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
