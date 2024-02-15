import 'package:equatable/equatable.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/posts/postentity.dart';

//defines a set of states related to fetching a single post in the application
abstract class GetSinglePostState extends Equatable {
  const GetSinglePostState();
}

class GetSinglePostInitial extends GetSinglePostState {
  @override
  List<Object> get props => [];
}

class GetSinglePostLoading extends GetSinglePostState {
  @override
  List<Object> get props => [];
}

class GetSinglePostLoaded extends GetSinglePostState {
  final PostEntity post;

  GetSinglePostLoaded({required this.post});
  @override
  List<Object> get props => [post];
}

class GetSinglePostFailure extends GetSinglePostState {
  @override
  List<Object> get props => [];
}
