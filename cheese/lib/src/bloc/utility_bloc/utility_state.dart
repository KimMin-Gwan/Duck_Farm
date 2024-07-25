import 'package:cheese/src/data_domain/data_domain.dart';
import 'package:equatable/equatable.dart';
import 'package:cheese/src/model/utility_model.dart';

abstract class UtilityState extends Equatable{
  @override
  List<Object> get props => [];
}

class InitUtilityState extends UtilityState{
  @override
  List<Object> get props => [];
}

class SearchBiasState extends UtilityState{
  final SearchBiasModel searchBiasModel;

  SearchBiasState(this.searchBiasModel);

  @override
  List<Object> get props => [searchBiasModel];
}

class SearchScheduleState extends UtilityState{
  final SearchScheduleModel searchScheduleModel;

  SearchScheduleState(this.searchScheduleModel);

  @override
  List<Object> get props => [searchScheduleModel];
}

