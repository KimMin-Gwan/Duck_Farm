import 'package:equatable/equatable.dart';
import 'package:cheese/src/model/bias_model.dart';


abstract class CoreState extends Equatable{
  @override
  List<Object> get props => [];
}

class InitCoreState extends CoreState{
  @override
  List<Object> get props => [];
}

class NoneBiasState extends CoreState{
  final List<Bias>bias;
  NoneBiasState(this.bias);

  @override
  List<Object> get props => [bias];
}

class BiasState extends CoreState{
  final List<Bias>bias;
  BiasState(this.bias);

  @override
  List<Object> get props => [bias];
}



