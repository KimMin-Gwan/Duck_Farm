import 'package:cheese/src/data_domain/data_domain.dart';
import 'package:equatable/equatable.dart';

abstract class UtilityEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class InitUtilityEvent extends UtilityEvent{
  @override
  List<Object> get props => [];
}


class SearchBiasEvent extends UtilityEvent{
  final String keyword;

  SearchBiasEvent(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class FollowBiasEvent extends UtilityEvent{
  final String bid;
  final String keyword;

  FollowBiasEvent(this.bid, this.keyword);

  @override
  List<Object> get props => [bid, keyword];
}

class SearchScheduleEvent extends UtilityEvent{
  final String keyword;

  SearchScheduleEvent(this.keyword);

  @override
  List<Object> get props => [keyword];
}
