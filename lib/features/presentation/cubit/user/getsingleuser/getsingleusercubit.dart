import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/user/getsingleuserusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/user/getsingleuser/getsingleuserstate.dart';

//This class serves as the business logic component responsible for handling the logic of fetching a single user and updating the UI accordingly.
class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  //This Cubit is responsible for managing the state related to fetching a single user
  final GetSingleUserUseCase getSingleUserUseCase;
  GetSingleUserCubit({required this.getSingleUserUseCase})
      : super(GetSingleUserInitial());
  Future<void> getSingleUser({required String uid}) async {
    emit(GetSingleUserLoading());
    try {
      // Calling the getSingleUserUseCase to fetch a single user
      final streamResponse = getSingleUserUseCase.call(uid);
      // Listening to the stream response
      streamResponse.listen((users) {
        // Emitting a state with the fetched single user when it's available
        emit(GetSingleUserLoaded(user: users.first));
      });
    } on SocketException catch (_) {
      emit(GetSingleUserFailure());
    } catch (_) {
      emit(GetSingleUserFailure());
    }
  }
}
