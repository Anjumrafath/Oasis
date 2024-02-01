import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/auth/authcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/auth/authstate.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/credential/credentialcubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/usercubit.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/credential/signinpage.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/mainscreen/mainscreen.dart';
import 'package:insta_cleanarchitecture/ongenerateroute.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/presentation/cubit/user/getsingleuser/getsingleusercubit.dart';
import 'firebase_options.dart';
import 'package:insta_cleanarchitecture/injection container.dart' as di;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "InstagramClone",
        darkTheme: ThemeData.dark(),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: "/",
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(uid: authState.uid);
                } else {
                  return SignInPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}