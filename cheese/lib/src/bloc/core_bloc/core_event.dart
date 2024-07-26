//import 'package:cheese/src/ui/image_list_category_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';


abstract class CoreEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class InitCoreEvent extends CoreEvent{

  @override
  List<Object> get props => [];
}

class StartMainServiceEvent extends CoreEvent{

  @override
  List<Object> get props => [];
}

class NoneBiasHomeDataEvent extends CoreEvent{
  String date = DateFormat('yyyy/MM/dd').format(DateTime.now());

  NoneBiasHomeDataEvent(this.date){}
  NoneBiasHomeDataEvent.none_date(){}
  @override
  List<Object> get props => [date];
}

class BiasHomeDataEvent extends CoreEvent{
  String date = DateFormat('yyyy/MM/dd').format(DateTime.now());
  bool initFlag = false;

  final String bid;

  BiasHomeDataEvent(this.date, this.bid);
  BiasHomeDataEvent.none_date(this.bid){initFlag = true;}

  @override
  List<Object> get props => [date, bid];
}

class DetailImageDataEvent extends CoreEvent{
  final String iid;

  DetailImageDataEvent(this.iid);

  @override
  List<Object> get props => [iid];
}

class BiasListEvent extends CoreEvent{
  @override
  List<Object> get props => [];
}

class ImageSearchEvent extends CoreEvent{
  // 멤버
  final String keyword;
  final String ordering;

  //생성자
  ImageSearchEvent(this.keyword, this.ordering);

  @override
  List<Object> get props => [keyword, ordering];
}

class ImageListCategoryEvent extends CoreEvent{
  // 멤버
  final String bid;
  final String ordering;

  //생성자
  ImageListCategoryEvent(this.bid, this.ordering);

  @override
  List<Object> get props => [bid, ordering];
}

class ImageListCategoryByScheduleEvent extends CoreEvent{
  // 멤버
  final String bid;
  final String sid;
  final String ordering;

  //생성자
  ImageListCategoryByScheduleEvent(this.bid, this.sid, this.ordering);

  @override
  List<Object> get props => [bid, sid, ordering];
}



class LoadBackwardEvent extends CoreEvent{
  @override
  List<Object> get props => [];
}

class CoreRefreshEvent extends CoreEvent{
  @override
  List<Object> get props => [];
}
