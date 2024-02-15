import 'package:equatable/equatable.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/user/userentity.dart';

//code defines a set of state classes for managing the state of a single other user
abstract class GetSingleOtherUserState extends Equatable {
  const GetSingleOtherUserState();
}

class GetSingleOtherUserInitial extends GetSingleOtherUserState {
  @override
  List<Object> get props => [];
}

class GetSingleOtherUserLoading extends GetSingleOtherUserState {
  @override
  List<Object> get props => [];
}

class GetSingleOtherUserLoaded extends GetSingleOtherUserState {
  final UserEntity otherUser;

  GetSingleOtherUserLoaded({required this.otherUser});
  @override
  List<Object> get props => [otherUser];
}

class GetSingleOtherUserFailure extends GetSingleOtherUserState {
  @override
  List<Object> get props => [];
}
