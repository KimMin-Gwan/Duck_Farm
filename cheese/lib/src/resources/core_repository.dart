//import 'package:cheese/src/model/user_model.dart';
import 'package:cheese/src/resources/core_network_provider.dart';
import 'package:cheese/src/model/home_data_model.dart';


class CoreRepository{
  final CoreNetworkProvider coreNetworkProvider = CoreNetworkProvider();


  Future<HomeDataModel> fetchNoneBiasHomeData(uid, date) => coreNetworkProvider.fetchNoneBiasHome(uid, date);
  Future<DetailImageModel> fetchDetailImageData(uid, iid) => coreNetworkProvider.fetchImageDetail(uid, iid);
}
