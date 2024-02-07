import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/followunfollowuserusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/getuserusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/updateuserusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/userstate.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetUsersUseCase getUsersUseCase;
  final FollowUnFollowUseCase followUnFollowUseCase;
  UserCubit({
    required this.followUnFollowUseCase,
    required this.updateUserUseCase,
    required this.getUsersUseCase,
  }) : super(UserInitial());
  Future<void> getUsers({required UserEntity user}) async {
    emit(UserLoading());
    try {
      final streamResponse = getUsersUseCase.call(user);
      streamResponse.listen((users) {
        emit(UserLoaded(users: users));
      });
    } on SocketException catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUser({required UserEntity user}) async {
    try {
      await updateUserUseCase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> followUnFollowUser({required UserEntity user}) async {
    try {
      await followUnFollowUseCase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
