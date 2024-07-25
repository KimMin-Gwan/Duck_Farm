

import 'package:cheese/src/data_domain/data_domain.dart';
import 'package:cheese/src/model/utility_model.dart';
import 'package:cheese/src/resources/network_provider/utility_network_provider.dart';

class UtilityRepository{
  final UtilityNetworkProvider _utilityNetworkProvider = UtilityNetworkProvider();

  Future<SearchBiasModel> fetchSearchBias(String keyword) => _utilityNetworkProvider.fetchSearchBias(keyword);
  Future<SearchScheduleModel> fetchSearchSchedule(String keyword) => _utilityNetworkProvider.fetchSearchSchedule(keyword);
  Future<User> fetchFollowBias(String uid, String bid) => _utilityNetworkProvider.fetchFollowBias(uid, bid);


}