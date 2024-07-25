import 'package:cheese/src/bloc/utility_bloc/utility_event.dart';
import 'package:cheese/src/data_domain/data_domain.dart';

abstract class SampleModel {
  final String stateCode;
  SampleModel(this.stateCode);
}

class SearchBiasModel extends SampleModel{
  final List<Bias> biasList;
  List<bool> followedBidList = [];

  SearchBiasModel({
    required String stateCode,
    required this.biasList,
  }) : super(stateCode);

  factory SearchBiasModel.fromJson(Map data) {
    List<Bias> biasList = [];

    for ( Map<String, dynamic> biasData in data['body']){
      Bias bias = Bias();
      bias.makeWithDict(biasData);
      biasList.add(bias);
    }

    return SearchBiasModel(
      stateCode: data['header']['state-code'],
      biasList: biasList
    );
  }
  void setFollowedBiasList(List<bool> followingFlag){
    followedBidList= followingFlag;
  }
}

class SearchScheduleModel extends SampleModel{
  final List<Schedule> scheduleList;

  SearchScheduleModel({
    required String stateCode,
    required this.scheduleList,
  }) : super(stateCode);

  factory SearchScheduleModel.fromJson(Map data) {
    List<Schedule> scheduleList = [];

    for ( Map<String, dynamic> biasData in data['body']){
      Schedule schedule = Schedule();
      schedule.makeWithDict(biasData);
      scheduleList.add(schedule);
    }

    return SearchScheduleModel(
        stateCode: data['header']['state-code'],
        scheduleList:scheduleList
    );
  }
}
