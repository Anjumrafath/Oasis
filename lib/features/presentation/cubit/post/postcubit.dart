import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
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

  // Stream<List<PostEntity>> getPosts({required PostEntity post}) {
  Future<void> getPosts({required PostEntity post}) async {
    emit(PostLoading());
    try {
      final streamResponse = readPostsUseCase.call(post);
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
      //print("type ${streamResponse.runtimeType}");
     