import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/getsingleotheruserusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/getsingleothercubit/getsingleotheruserstate.dart';

class GetSingleOtherUserCubit extends Cubit<GetSingleOtherUserState> {
  final GetSingleOtherUserUseCase getSingleOtherUserUseCase;
  GetSingleOtherUserCubit({required this.getSingleOtherUserUseCase})
      : super(GetSingleOtherUserInitial());

  Future<void> getSingleOtherUser({required String otherUid}) async {
    // Emitting a loading state to indicate that the process of fetching a single other user has started
    emit(GetSingleOtherUserLoading());
    try {
      // Calling the getSingleOtherUserUseCase to fetch a single other user
      final streamResponse = getSingleOtherUserUseCase.call(otherUid);
      // Listening to the stream response
      streamResponse.listen((users) {
        // Emitting a state with the fetched single other user when it's available
        emit(GetSingleOtherUserLoaded(otherUser: users.first));
      });
    } on SocketException catch (_) {
      // Catching a SocketException and emitting a failure state if one occurs
      emit(GetSingleOtherUserFailure());
    } catch (_) {
      // Catching any other exceptions and emitting a failure state
      emit(GetSingleOtherUserFailure());
    }
  }
}
