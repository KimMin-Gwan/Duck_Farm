import 'package:equatable/equatable.dart';

abstract class SignState extends Equatable{
  @override
  List<Object> get props => [];
}


class InitSignState extends SignState{
  @override
  List<Object> get props => [];
}


class EmailInputState extends SignState{

  @override
  List<Object> get props => [];
}


class TryLoginState extends SignState{
  final String email;

  TryLoginState(this.email);

  @override
  List<Object> get props => [email];
}

class TrySendEmailState extends SignState{

  @override
  List<Object> get props => [];
}
