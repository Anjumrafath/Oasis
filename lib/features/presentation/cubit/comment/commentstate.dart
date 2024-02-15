import 'package:equatable/equatable.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/comment/commententity.dart';

//CommentState class and its subclasses are used to represent the different states of comments in application

abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentInitial extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentLoaded extends CommentState {
  final List<CommentEntity> comments;

  CommentLoaded({required this.comments});
  @override
  List<Object> get props => [comments];
}

class CommentFailure extends CommentState {
  @override
  List<Object> get props => [];
}
