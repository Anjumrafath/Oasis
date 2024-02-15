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
    // Emitting the loading state before fetching the single post.
    emit(GetSinglePostLoading());
    try {
      // Calling the use case to read the single post.
      final streamResponse = readSinglePostUseCase.call(postId);
      // Listening to the stream response for changes in the single post.
      streamResponse.listen((posts) {
        emit(GetSinglePostLoaded(post: posts.first));
      });
    } on SocketException catch (_) {
      // Handling socket exceptions by emitting a failure state.
      emit(GetSinglePostFailure());
    } catch (_) {
      emit(GetSinglePostFailure());
    }
  }
}
