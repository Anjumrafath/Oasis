import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/auth/authstate.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/credential/credentialcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/credential/credentialstate.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/credential/signinpage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/mainscreen/mainscreen.dart';
import 'package:insta_cleanarchitecture/features/presentation/widgets/formcontainerwidget.dart';
import 'package:insta_cleanarchitecture/profilewidget.dart';

import '../../../domain/entity/user/userentity.dart';
import '../../cubit/auth/authcubit.dart';
import '../../widgets/buttoncontainerwidget.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  bool _isSigningUp = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  File? _image;
  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(
        source: ImageSource.camera,
      );

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backGroundColor,
        body: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {
            if (credentialState is CredentialSuccess) {
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            if (credentialState is CredentialFailure) {
              toast("Invalid Email and Password");
            }
          },
          builder: (context, credentialState) {
            if (credentialState is CredentialSuccess) {
              return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(uid: authState.uid);
                } else {
                  return _bodyWidget();
                }
              });
            }

            return _bodyWidget();
          },
        ));
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Center(child: Image.asset("assets/instagramlogo.png", width: 200)),
          sizeVer(15),
          Center(
            child: Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                    child: profileWidget(
                      image: _image,
                    ),
                  ),
                ),
                Positioned(
                  right: -10,
                  bottom: -15,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(Icons.add_a_photo, color: blueColor),
                  ),
                ),
              ],
            ),
          ),
          sizeVer(15),
          FormContainerWidget(
            controller: _usernameController,
            hintText: "Username",
          ),
          sizeVer(15),
          FormContainerWidget(
            controller: _emailController,
            hintText: "Email",
          ),
          sizeVer(15),
          FormContainerWidget(
            controller: _passwordController,
            hintText: "Password",
            isPasswordField: true,
          ),
          sizeVer(15),
          FormContainerWidget(
            controller: _bioController,
            hintText: "Bio",
          ),
          sizeVer(15),
          ButtonContainerWidget(
            color: blueColor,
            text: "Sign Up",
            onTapListener: () {
              _signUpUser();
            },
          ),
          sizeVer(10),
          _isSigningUp == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please wait",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    sizeHor(10),
                    CircularProgressIndicator()
                  ],
                )
              : Container(width: 0, height: 0),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Divider(
            color: secondaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?",
                  style: TextStyle(color: primaryColor)),
              InkWell(
                onTap: () {
                  //  Navigator.pushAndRemoveUntil(
                  //   context,
                  //  MaterialPageRoute(builder: (context) => SignInPage()),
                  // (route) => false);
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageConst.signUpPage, (route) => false);
                },
                child: Text("Sign In.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: primaryColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _signUpUser() {
    setState(() {
      _isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
          user: UserEntity(
            email: _emailController.text,
            password: _passwordController.text,
            bio: _bioController.text,
            username: _usernameController.text,
            totalPosts: 0,
            totalFollowing: 0,
            followers: [],
            totalFollowers: 0,
            profileUrl: " ",
            website: " ",
            following: [],
            name: " ",
            imageFile: _image,
          ),
        )
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _usernameController.clear();
      _bioController.clear();
      _emailController.clear();
      _passwordController.clear();
      _isSigningUp = false;
    });
  }
}
