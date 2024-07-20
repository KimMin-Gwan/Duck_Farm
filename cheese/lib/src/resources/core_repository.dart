//import 'package:cheese/src/model/user_model.dart';
import 'package:cheese/src/model/image_model.dart';
import 'package:cheese/src/resources/core_network_provider.dart';
import 'package:cheese/src/model/home_data_model.dart';
import 'package:cheese/src/model/bias_model.dart';

class CoreRepository{
  final CoreNetworkProvider coreNetworkProvider = CoreNetworkProvider();


  Future<HomeDataModel> fetchNoneBiasHomeData(uid, date) => coreNetworkProvider.fetchNoneBiasHome(uid, date);
  Future<DetailImageModel> fetchDetailImageData(uid, iid) => coreNetworkProvider.fetchImageDetail(uid, iid);
  Future<ImageListCategoryModel> fetchImageListCategory(uid, bid)
  => coreNetworkProvider.fetchImageListCategory(uid, bid);
  Future<ImageListCategoryModel> fetchImageListCategoryBySchedule(uid, bid, sid)
  => coreNetworkProvider.fetchImageListCategoryBySchedule(uid, bid, sid);
  Future<BiasListModel> fetchBiasList(uid,bid)=>coreNetworkProvider.fetchBiasList(uid,bid);
}
