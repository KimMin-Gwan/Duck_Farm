import 'package:equatable/equatable.dart';
import 'package:cheese/src/model/bias_model.dart';
import 'package:cheese/src/model/home_data_model.dart';


abstract class CoreState extends Equatable{
  @override
  List<Object> get props => [];
}

class InitCoreState extends CoreState{
  @override
  List<Object> get props => [];
}

class NoneBiasState extends CoreState{
  final HomeDataModel homeDataModel;
  NoneBiasState(this.homeDataModel);

  @override
  List<Object> get props => [homeDataModel];
}


class DetailImageState extends CoreState{
  final DetailImageModel detailImageModel;

  DetailImageState(this.detailImageModel);

  @override
  List<Object> get props => [detailImageModel];
}


