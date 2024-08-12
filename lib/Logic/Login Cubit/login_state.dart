part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class ChangeObscurityState extends LoginState{}

final class LoadingLoginState extends LoginState{}
final class SuccessLoginState extends LoginState{}
final class FailedLoginState extends LoginState{
  final String error;
  FailedLoginState(this.error);
}
