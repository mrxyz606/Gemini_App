part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ChangeEditState extends ProfileState {}

final class LogoutState extends ProfileState {}

final class PickingImageState extends ProfileState {}
final class SuccessPickingImageState extends ProfileState {}

final class SuccessGetUserState extends ProfileState {}
final class LoadingGetUserState extends ProfileState {}
final class FailedGetUserState extends ProfileState {
  final String error;
  FailedGetUserState(this.error);
}

final class SuccessChangePictureState extends ProfileState {}
final class LoadingChangePictureState extends ProfileState {}
final class FailedChangePictureState extends ProfileState {
  final String error;
  FailedChangePictureState(this.error);
}

final class SuccessChangeNameState extends ProfileState {}
final class LoadingChangeNameState extends ProfileState {}
final class FailedChangeNameState extends ProfileState {
  final String error;
  FailedChangeNameState(this.error);
}

final class SuccessUploadResultsState extends ProfileState {}
final class LoadingUploadResultsState extends ProfileState {}
final class FailedUploadResultsState extends ProfileState {
  final String error;
  FailedUploadResultsState(this.error);
}

final class SuccessGetResultsState extends ProfileState {}
final class LoadingGetResultsState extends ProfileState {}
final class FailedGetResultsState extends ProfileState {
  final String error;
  FailedGetResultsState(this.error);
}

