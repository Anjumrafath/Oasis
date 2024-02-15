import 'package:equatable/equatable.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';

// defines a set of state classes for managing the state of posts
abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoaded extends PostState {
  final List<PostEntity> posts;

  PostLoaded({required this.posts});
  @override
  List<Object> get props => [posts];
}

class PostFailure extends PostState {
  @override
  List<Object> get props => [];
}
