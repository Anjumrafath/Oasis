import 'package:equatable/equatable.dart';

import '../../../domain/entity/user/userentity.dart';

//defines a set of state classes for managing the state related to user data.
abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final List<UserEntity> users;

  UserLoaded({required this.users});

  //props getter is overridden to include the list of users, ensuring that instances of this class are considered equal if they contain the same list of users.
  @override
  List<Object> get props => [users];
}

class UserFailure extends UserState {
  @override
  List<Object> get props => [];
}
