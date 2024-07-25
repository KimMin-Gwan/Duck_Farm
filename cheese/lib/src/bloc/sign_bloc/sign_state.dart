import 'package:equatable/equatable.dart';
import 'package:cheese/src/model/sign_model.dart';

abstract class SignState extends Equatable{
  @override
  List<Object> get props => [];
}


class InitSignState extends SignState{
  @override
  List<Object> get props => [];
}

class PasswordChangeState extends SignState{
  @override
  List<Object> get props => [];
}

class TryLoginState extends SignState{
  final TryLoginModel tryLoginModel;

  TryLoginState(this.tryLoginModel);

  @override
  List<Object> get props => [tryLoginModel];
}

class LoginSuccessState extends SignState{
  final TryLoginModel tryLoginModel;

  LoginSuccessState(this.tryLoginModel);

  @override
  List<Object> get props => [tryLoginModel];
}

class EmailInputState extends SignState{

  @override
  List<Object> get props => [];
}

class TrySendEmailState extends SignState{
  final bool state;

  TrySendEmailState(this.state);

  @override
  List<Object> get props => [state];
}

class PasswordInputState extends SignState{
  @override
  List<Object> get props => [];
}

class NameBirthdayInputState extends SignState{
  @override
  List<Object> get props => [];
}

class NicknameInputState extends SignState{

  @override
  List<Object> get props => [];
}

class CheckTermsState extends SignState{
  @override
  List<Object> get props => [];
}

class EndOfSignUpState extends SignState{
  @override
  List<Object> get props => [];
}






