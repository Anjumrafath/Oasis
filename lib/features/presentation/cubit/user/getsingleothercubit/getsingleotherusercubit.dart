import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/getsingleotheruserusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/getsingleothercubit/getsingleotheruserstate.dart';

class GetSingleOtherUserCubit extends Cubit<GetSingleOtherUserState> {
  final GetSingleOtherUserUseCase getSingleOtherUserUseCase;
  GetSingleOtherUserCubit({required this.getSingleOtherUserUseCase})
      : super(GetSingleOtherUserInitial());

  Future<void> getSingleOtherUser({required String otherUid}) async {
    emit(GetSingleOtherUserLoading());
    try {
      final streamResponse = getSingleOtherUserUseCase.call(otherUid);
      streamResponse.listen((users) {
        emit(GetSingleOtherUserLoaded(otherUser: users.first));
      });
    } on SocketException catch (_) {
      emit(GetSingleOtherUserFailure());
    } catch (_) {
      emit(GetSingleOtherUserFailure());
    }
  }
}
