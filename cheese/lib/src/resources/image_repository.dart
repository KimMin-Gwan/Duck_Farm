import 'package:cheese/src/model/image_model.dart';
import 'package:cheese/src/resources/image_upload_network_provider.dart';

class ImageRepository{
  String uid = "1234-abcd-5678";
  final ImageUploadNetworkProvider imageUploadNetworkProvider = ImageUploadNetworkProvider();


  Future<ImageUploadModel> fetchTryGetImageData(
      bid, schedule, date, detail, link, location, numImages,)
    => imageUploadNetworkProvider.fetchTryGetImageData(
      uid, bid, schedule, date, detail, link, location, numImages);

  Future<Map<String, dynamic>> fetchTryImageUpload(
      args, fileNames) => imageUploadNetworkProvider.fetchTryImageUpload(
    args, fileNames);
}