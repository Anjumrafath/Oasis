import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/poststate.dart';

import '../../../domain/entity/posts/postentity.dart';
import '../../../domain/usecases/firebaseusecases/post/createpostusecase.dart';
import '../../../domain/usecases/firebaseusecases/post/deletepostusecase.dart';
import '../../../domain/usecases/firebaseusecases/post/likepostusecase.dart';
import '../../../domain/usecases/firebaseusecases/post/readpostusecase.dart';
import '../../../domain/usecases/firebaseusecases/post/updatepostusecase.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final LikePostUseCase likePostUseCase;
  final ReadPostsUseCase readPostsUseCase;
  final UpdatePostUseCase updatePostUseCase;

  PostCubit({
    required this.createPostUseCase,
    required this.deletePostUseCase,
    required this.likePostUseCase,
    required this.readPostsUseCase,
    required this.updatePostUseCase,
  }) : super(PostInitial());
  Future<void> getPosts({required PostEntity post}) async {
    emit(PostLoading());
    try {
      final streamResponse = await readPostsUseCase.call(post);
      print("type ${streamResponse.runtimeType}");
      streamResponse.listen((posts) {
        emit(PostLoaded(posts: posts));
      });
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> likePost({required PostEntity post}) async {
    try {
      await likePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> deletePost({required PostEntity post}) async {
    try {
      await deletePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> createPost({required PostEntity post}) async {
    try {
      await createPostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> updatePost({required PostEntity post}) async {
    try {
      await updatePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }
}
