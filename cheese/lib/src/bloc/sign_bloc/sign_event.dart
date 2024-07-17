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

class EmailInputEvent extends SignEvent{
  final String email;

  EmailInputEvent(this.email);

  @override
  List<Object> get props => [email];
}

class TryLoginEvent extends SignEvent{
  final String email;
  final String password;

  TryLoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class TrySendEmailEvent extends SignEvent{
  @override
  List<Object> get props => [];
}
