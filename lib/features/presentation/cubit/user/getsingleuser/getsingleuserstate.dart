import 'package:equatable/equatable.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';

//code defines a set of state classes for managing the state of fetching a single user
abstract class GetSingleUserState extends Equatable {
  const GetSingleUserState();

  get user => null;
}

class GetSingleUserInitial extends GetSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleUserLoading extends GetSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleUserLoaded extends GetSingleUserState {
  final UserEntity user;

  GetSingleUserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class GetSingleUserFailure extends GetSingleUserState {
  @override
  List<Object> get props => [];
}
