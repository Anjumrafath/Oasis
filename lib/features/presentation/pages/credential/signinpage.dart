import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/const.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/credential/credentialcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/credential/credentialstate.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/credential/signuppage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/mainscreen/mainscreen.dart';
import 'package:insta_cleanarchitecture/features/presentation/widgets/buttoncontainerwidget.dart';
import 'package:insta_cleanarchitecture/features/presentation/widgets/formcontainerwidget.dart';

import '../../cubit/auth/authcubit.dart';
import '../../cubit/auth/authstate.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isSigningIn = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              },
            );
          }
          return _bodyWidget();
        },
      ),
    );
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
          sizeVer(30),
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
          ButtonContainerWidget(
            color: blueColor,
            text: "Sign In",
            onTapListener: () {
              _signInUser();
            },
          ),
          sizeVer(10),
          _isSigningIn == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please wait",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    sizeHor(10),
                    CircularProgressIndicator(),
                  ],
                )
              : Container(width: 0, height: 0),
          Flexible(
            child: Container(),
            flex: 2,
          ),
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
              Text("Don't have an account?",
                  style: TextStyle(color: primaryColor)),
              InkWell(
                onTap: () {
                  // Navigator.pushAndRemoveUntil(
                  //  context,
                  //  MaterialPageRoute(builder: (context) => SignUpPage()),
                  //  (route) => false);
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageConst.signUpPage, (route) => false);
                },
                child: Text("Sign Up.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: primaryColor)),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _signInUser() {
    setState(() {
      _isSigningIn = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signInUser(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((value) {
      _clear();
    });
  }

  _clear() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _isSigningIn = true;
    });
  }
}
