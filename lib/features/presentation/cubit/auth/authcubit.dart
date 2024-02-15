import "package:flutter/material.dart";
import "package:bloc/bloc.dart";
import "package:insta_cleanarchitecture/features/presentation/cubit/auth/authstate.dart";
import "package:insta_cleanarchitecture/features/domain/usecases/user/getcurrentuidusecase.dart";
import "package:insta_cleanarchitecture/features/domain/usecases/user/is_signinuserusecase.dart";

import "../../../domain/usecases/user/signoutuserusecase.dart";
import "package:equatable/equatable.dart";

class AuthCubit extends Cubit<AuthState> {
  final SignOutUseCase signOutUseCase;
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  AuthCubit(
      {required this.signOutUseCase,
      required this.isSignInUseCase,
      required this.getCurrentUidUseCase})
      : super(AuthInitial());
  // Method called when the app is started.
  Future<void> appStarted(BuildContext context) async {
    try {
      bool isSignIn = await isSignInUseCase.call();
      if (isSignIn == true) {
        final uid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

// Method called when the user is logged in.
  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

// Method called when the user is logged out.
  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
