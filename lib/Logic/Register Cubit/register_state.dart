part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class ChangeObscurityState extends RegisterState {}

final class LoadingRegisterState extends RegisterState{}
final class FailedRegisterState extends RegisterState{
  final String error;
  FailedRegisterState(this.error);
}

final class LoadingCreateUserState extends RegisterState{}
final class SuccessCreateUserState extends RegisterState{}
final class FailedCreateUserState extends RegisterState{
  final String error;
  FailedCreateUserState(this.error);
}


