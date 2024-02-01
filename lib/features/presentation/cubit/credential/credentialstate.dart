import 'package:equatable/equatable.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();
}

class CredentialInitial extends CredentialState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CredentialLoading extends CredentialState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CredentialSuccess extends CredentialState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CredentialFailure extends CredentialState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
