import 'package:equatable/equatable.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/reply/replyentity.dart';

//these state classes provide a structured way to represent different states of replays in the application
abstract class ReplayState extends Equatable {
  const ReplayState();
}

class ReplayInitial extends ReplayState {
  @override
  List<Object> get props => [];
}

class ReplayLoading extends ReplayState {
  @override
  List<Object> get props => [];
}

class ReplayLoaded extends ReplayState {
  final List<ReplayEntity> replays;

  ReplayLoaded({required this.replays});

  @override
  List<Object> get props => [replays];
}

class ReplayFailure extends ReplayState {
  @override
  List<Object> get props => [];
}
