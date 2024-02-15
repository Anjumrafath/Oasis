import 'package:equatable/equatable.dart';

// Abstract class representing the state of credential-related operations.
abstract class CredentialState extends Equatable {
  const CredentialState();
}

// Initial state when no credential-related operation has been performed yet.
class CredentialInitial extends CredentialState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// State indicating that a credential-related operation is in progress.
class CredentialLoading extends CredentialState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// State indicating that a credential-related operation was successful.
class CredentialSuccess extends CredentialState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// State indicating that a credential-related operation failed.
class CredentialFailure extends CredentialState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
