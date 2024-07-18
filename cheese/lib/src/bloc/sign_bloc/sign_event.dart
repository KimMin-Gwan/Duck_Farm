import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';


abstract class SignEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class InitSignEvent extends SignEvent{

  @override
  List<Object> get props => [];
}

class PasswordChangeEvent extends SignEvent{
  final String password;
  PasswordChangeEvent(this.password);

  @override
  List<Object> get props => [password];
}

class StartSignEvent extends SignEvent{

  @override
  List<Object> get props => [];
}


class TryLoginEvent extends SignEvent{
  final String email;
  final String password;

  TryLoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LoadBackwardEvent extends SignEvent{
  @override
  List<Object> get props => [];
}

class EmailInputEvent extends SignEvent{
  final String email;

  EmailInputEvent(this.email);

  @override
  List<Object> get props => [email];
}

/*
class TryLoginEvent extends SignEvent{
  final String email;
  final String password;

  TryLoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

 */

class TrySendEmailEvent extends SignEvent{
  @override
  List<Object> get props => [];
}

class PasswordInputEvent extends SignEvent{
  final String password;
  PasswordInputEvent(this.password);

  @override
  List<Object> get props => [password];
}

class NameBirthdayInputEvent extends SignEvent{
  final String name;
  final String birthday;

  NameBirthdayInputEvent(this.name, this.birthday);

  @override
  List<Object> get props => [name, birthday];
}

class NicknameInputEvent extends SignEvent{
  final String nickname;

  NicknameInputEvent(this.nickname);

  @override
  List<Object> get props => [nickname];
}

class CheckTermsEvent extends SignEvent{
  final List<bool> terms;

  CheckTermsEvent(this.terms);

  @override
  List<Object> get props => [terms];
}

class EndOfSignUpEvent extends SignEvent{
  @override
  List<Object> get props => [];
}
