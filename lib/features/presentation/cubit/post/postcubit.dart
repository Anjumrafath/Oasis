import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/firebaseusecases/post/createpostusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/firebaseusecases/post/deletepostusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/firebaseusecases/post/likepostusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/firebaseusecases/post/readpostusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/firebaseusecases/post/updatepostusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/post/poststate.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final LikePostUseCase likePostUseCase;
  final ReadPostsUseCase readPostsUseCase;
  final UpdatePostUseCase updatePostUseCase;
  PostCubit(
      {required this.updatePostUseCase,
      required this.deletePostUseCase,
      required this.likePostUseCase,
      required this.createPostUseCase,
      required this.readPostsUseCase})
      : super(PostInitial());

  Future<void> getPosts({required PostEntity post}) async {
    emit(PostLoading());
    try {
      // Calling the readPostsUseCase to fetch posts
      final streamResponse = readPostsUseCase.call(post);
      // Listening to the stream response
      streamResponse.listen((posts) {
        // Emitting a state with the received posts when they are available
        emit(PostLoaded(posts: posts));
      });
    } on SocketException catch (_) {
      // Catching a SocketException and emitting a failure state if one occurs
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> likePost({required PostEntity post}) async {
    try {
      // Calling the likePostUseCase to like the post
      await likePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> deletePost({required PostEntity post}) async {
    try {
      // Call the deletePostUseCase to delete the post
      await deletePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> createPost({required PostEntity post}) async {
    try {
      // Call the createPostUseCase to create the post
      await createPostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> updatePost({required PostEntity post}) async {
    try {
      // Call the updatePostUseCase to update the post
      await updatePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }
}
