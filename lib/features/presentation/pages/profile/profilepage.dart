import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/auth/authcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/profile/editprofilepage.dart';
import 'package:insta_cleanarchitecture/profilewidget.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity currentUser;
  const ProfilePage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Text("${currentUser.username}"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                _openBottomModelSheet(context);
              },
              child: Icon(
                Icons.menu,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: profileWidget(
                        imageUrl: currentUser.profileUrl,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "${currentUser.totalPosts}",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          sizeVer(8),
                          Text(
                            "Posts",
                            style: TextStyle(color: primaryColor),
                          )
                        ],
                      ),
                      sizeHor(20),
                      Column(
                        children: [
                          Text(
                            "${currentUser.totalFollowers}",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          sizeVer(8),
                          Text(
                            "Followers",
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          )
                        ],
                      ),
                      sizeHor(20),
                      Column(
                        children: [
                          Text(
                            "${currentUser.totalFollowing}",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          sizeVer(8),
                          Text(
                            "Following",
                            style: TextStyle(color: primaryColor),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              sizeVer(10),
              Text(
                "${currentUser.name == " " ? currentUser.username : currentUser.name}",
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              ),
              sizeVer(10),
              Text(
                "${currentUser.bio}",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
              sizeVer(10),
              GridView.builder(
                  itemCount: 32,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, Index) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: secondaryColor,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _openBottomModelSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(color: backGroundColor.withOpacity(0.8)),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "More Options",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: primaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 1,
                      color: secondaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageConst.editProfilePage,
                              arguments: currentUser);
                          //  arguments: currentUser);
                          //  Navigator.push(
                          //  context,
                          //  MaterialPageRoute(
                          //     builder: (context) => EditProfilePage()));
                        },
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 1,
                      color: secondaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<AuthCubit>(context).loggedOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, PageConst.signInPage, (route) => false);
                        },
                        child: Text(
                          "LogOut",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
