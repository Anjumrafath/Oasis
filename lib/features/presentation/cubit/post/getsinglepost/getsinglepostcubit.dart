import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/firebaseusecases/post/readsinglepostusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/getsinglepost/getsinglepoststate.dart';

class GetSinglePostCubit extends Cubit<GetSinglePostState> {
  final ReadSinglePostUseCase readSinglePostUseCase;
  GetSinglePostCubit({required this.readSinglePostUseCase})
      : super(GetSinglePostInitial());

  Future<void> getSinglePost({required String postId}) async {
    emit(GetSinglePostLoading());
    try {
      final streamResponse = readSinglePostUseCase.call(postId);
      streamResponse.listen((posts) {
        emit(GetSinglePostLoaded(post: posts.first));
      });
    } on SocketException catch (_) {
      emit(GetSinglePostFailure());
    } catch (_) {
      emit(GetSinglePostFailure());
    }
  }
}
