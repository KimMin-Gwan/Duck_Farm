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
  @override
  List<Object> get props => [];
}

class DetailImageDataEvent extends CoreEvent{
  final String iid;

  DetailImageDataEvent(this.iid);

  @override
  List<Object> get props => [iid];

}