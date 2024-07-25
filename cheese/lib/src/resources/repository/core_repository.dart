//import 'package:cheese/src/model/user_model.dart';
import 'package:cheese/src/model/image_model.dart';
import 'package:cheese/src/resources/network_provider/core_network_provider.dart';
import 'package:cheese/src/model/home_data_model.dart';
import 'package:cheese/src/model/bias_model.dart';

class CoreRepository{
  final CoreNetworkProvider coreNetworkProvider = CoreNetworkProvider();


  Future<HomeDataModel> fetchNoneBiasHomeData(uid, date) => coreNetworkProvider.fetchNoneBiasHome(uid, date);
  Future<DetailImageModel> fetchDetailImageData(uid, iid) => coreNetworkProvider.fetchImageDetail(uid, iid);
  Future<BiasListModel> fetchBiasList(uid)=>coreNetworkProvider.fetchBiasList(uid);
  Future<ImageListCategoryModel> fetchImageListCategory(uid, bid, ordering, numImage)
  => coreNetworkProvider.fetchImageListCategory(uid, bid, ordering, numImage);
  Future<ImageListCategoryModel> fetchImageListCategoryBySchedule(uid, bid, sid, ordering, numImage)
  => coreNetworkProvider.fetchImageListCategoryBySchedule(uid, bid, sid, ordering, numImage);
}
