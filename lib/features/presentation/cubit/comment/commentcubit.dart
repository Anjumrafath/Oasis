import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/comment/commententity.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/comment/createcommentusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/comment/deletecommentusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/comment/likecommentusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/comment/readcommentusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/comment/updatecommentusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/comment/commentstate.dart';

class CommentCubit extends Cubit<CommentState> {
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final LikeCommentUseCase likeCommentUseCase;
  final ReadCommentsUseCase readCommentsUseCase;
  final UpdateCommentUseCase updateCommentUseCase;
  CommentCubit(
      {required this.updateCommentUseCase,
      required this.readCommentsUseCase,
      required this.likeCommentUseCase,
      required this.deleteCommentUseCase,
      required this.createCommentUseCase})
      : super(CommentInitial());
  // Method to fetch comments for a given post ID.

  Future<void> getComments({required String postId}) async {
    emit(CommentLoading());
    try {
      // Call the readCommentsUseCase to get a stream of comments for the given post ID.
      final streamResponse = readCommentsUseCase.call(postId);
      // Listen to the stream response for incoming comments.
      streamResponse.listen((comments) {
        // Emit a CommentLoaded state with the fetched comments.
        emit(CommentLoaded(comments: comments));
      });
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

// Method to like a comment.
  Future<void> likeComment({required CommentEntity comment}) async {
    try {
      await likeCommentUseCase.call(comment);
    } on SocketException catch (_) {
      // If there's a socket exception (network error), emit a CommentFailure state.
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

// Method to delete a comment.
  Future<void> deleteComment({required CommentEntity comment}) async {
    try {
      await deleteCommentUseCase.call(comment);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }
  // Method to create a new comment.

  Future<void> createComment({required CommentEntity comment}) async {
    try {
      await createCommentUseCase.call(comment);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

// Method to update a comment.
  Future<void> updateComment({required CommentEntity comment}) async {
    try {
      await updateCommentUseCase.call(comment);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }
}
