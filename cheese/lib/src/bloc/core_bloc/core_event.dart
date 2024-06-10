import 'package:equatable/equatable.dart';
import 'package:cheese/src/model/user_model.dart';


abstract class CoreEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class InitCoreEvent extends CoreEvent{

  @override
  List<Object> get props => [];
}

class NoneBiasHomeDataEvent extends CoreEvent{
  final UserModel userModel;

  NoneBiasHomeDataEvent(this.userModel);

  @override
  List<Object> get props => [];
}