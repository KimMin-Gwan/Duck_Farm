import 'package:cheese/src/ui/image_list_category_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:cheese/src/model/user_model.dart';
import 'package:intl/intl.dart';


abstract class CoreEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class InitCoreEvent extends CoreEvent{

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

class DetailImageDataEvent extends CoreEvent{
  final String iid;

  DetailImageDataEvent(this.iid);

  @override
  List<Object> get props => [iid];
}

class ImageListCategoryEvent extends CoreEvent{
  // 멤버
  final String bid;

  //생성자
  ImageListCategoryEvent(this.bid);

  @override
  List<Object> get props => [bid];
}

class ImageListCategoryByScheduleEvent extends CoreEvent{
  // 멤버
  final String bid;
  final String sid;

  //생성자
  ImageListCategoryByScheduleEvent(this.bid, this.sid);

  @override
  List<Object> get props => [bid, sid];
}



class LoadBackwardEvent extends CoreEvent{
  @override
  List<Object> get props => [];
}
