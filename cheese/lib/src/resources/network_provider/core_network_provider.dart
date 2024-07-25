import 'dart:ui';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/model/home_data_model.dart';
import 'package:cheese/src/model/image_model.dart';
import 'package:cheese/src/model/user_model.dart';
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:cheese/src/resources/main_json_parser.dart';
import 'package:cheese/src/model/bias_model.dart';

class NoneBiasApiJsonParser extends MainJsonParser{
  final Map body = {
    'uid' : '',
    'date' : ''
  };
  Uri __url = Uri();

  NoneBiasApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(uid, date){
    body['uid'] = uid;
    body['date'] = date;
  }

  String getData() => super.makeSendData(this.body);

  Uri getUri() => this.__url;
}

class BiasListApiJsonParser extends MainJsonParser{
  final Map body = {
    'uid' : '',
  };
  Uri __url = Uri();

  BiasListApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(uid){
    body['uid'] = uid;
  }

  String getData() => super.makeSendData(this.body);

  Uri getUri() => this.__url;
}

class ImageDetailApiJsonParser extends MainJsonParser{
  final Map body = {
    'uid' : '',
    'iid' : ''
  };
  Uri __url = Uri();

  ImageDetailApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(uid, iid){
    body['uid'] = uid;
    body['iid'] = iid;
  }

  String getData() => super.makeSendData(this.body);

  Uri getUri() => this.__url;
}

class ImageListCategoryApiJsonParser extends MainJsonParser{
  final Map body = {
    'uid' : '',
    'bid' : '',
    'ordering' : '',
    'num_image' : 0
  };
  Uri __url = Uri();

  ImageListCategoryApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(uid, bid, ordering, numImage){
    body['uid'] = uid;
    body['bid'] = bid;
    body['ordering'] = ordering;
    body['numImage'] = numImage;
  }

  String getData() => super.makeSendData(this.body);

  Uri getUri() => this.__url;
}

class ImageListCategoryByScheduleApiJsonParser extends MainJsonParser{
  final Map body = {
    'uid' : '',
    'bid' : '',
    'sid' : '',
    'ordering' : '',
    'num_image' : 0
  };
  Uri __url = Uri();

  ImageListCategoryByScheduleApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(uid, bid, sid, ordering, numImage){
    body['uid'] = uid;
    body['bid'] = bid;
    body['sid'] = sid;
    body['ordering'] = ordering;
    body['num_image'] = numImage;
  }

  String getData() => super.makeSendData(this.body);

  Uri getUri() => this.__url;
}


class CoreNetworkProvider{
  final String none_bias_endpoint = '/core_system/none_bias_home_data';
  final String image_detail_endpoint = '/core_system/image_detail';
  final String imageListCategoryEndpoint= '/core_system/get_image_list_by_bias';
  final String imageListCategoryByScheduleEndpoint= '/core_system/get_image_list_by_bias_n_schedule';
  final String biasListEndpoint = '/core_system/get_bias_following';
  Client client = Client();

  Future<HomeDataModel> fetchNoneBiasHome(String uid, String date) async {
    NoneBiasApiJsonParser noneBiasApiJsonParser = NoneBiasApiJsonParser(this.none_bias_endpoint);
    noneBiasApiJsonParser.setHeader(uid, none_bias_endpoint);
    noneBiasApiJsonParser.makeBodyData(uid, date);

    final response = await client.post(
        noneBiasApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: noneBiasApiJsonParser.getData()
    );
    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return HomeDataModel.fromJson(jsonDecode(jsonDecode(utf8.decode(response.bodyBytes))));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<DetailImageModel> fetchImageDetail(String uid, String iid) async {
    ImageDetailApiJsonParser imageDetailApiJsonParser= ImageDetailApiJsonParser(this.image_detail_endpoint);
    imageDetailApiJsonParser.setHeader(uid, image_detail_endpoint);
    imageDetailApiJsonParser.makeBodyData(uid, iid);

    final response = await client.post(
        imageDetailApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: imageDetailApiJsonParser.getData()
    );
    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return DetailImageModel.fromJson(jsonDecode(jsonDecode(utf8.decode(response.bodyBytes))));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ImageListCategoryModel> fetchImageListCategory(
      String uid, String bid, String ordering, int numImage) async {
    ImageListCategoryApiJsonParser imageListCategoryApiJsonParser= ImageListCategoryApiJsonParser(this.imageListCategoryEndpoint);
    imageListCategoryApiJsonParser.setHeader(uid, this.imageListCategoryEndpoint);
    imageListCategoryApiJsonParser.makeBodyData(uid, bid, ordering, numImage);

    final response = await client.post(
        imageListCategoryApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: imageListCategoryApiJsonParser.getData()
    );
    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return ImageListCategoryModel.fromJson(jsonDecode(jsonDecode(utf8.decode(response.bodyBytes))));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ImageListCategoryModel> fetchImageListCategoryBySchedule(
      String uid, String bid, String sid, String ordering, int numImage) async {
    ImageListCategoryByScheduleApiJsonParser imageListCategoryByScheduleApiJsonParser= ImageListCategoryByScheduleApiJsonParser(this.imageListCategoryByScheduleEndpoint);
    imageListCategoryByScheduleApiJsonParser.setHeader(uid, this.imageListCategoryByScheduleEndpoint);
    imageListCategoryByScheduleApiJsonParser.makeBodyData(uid, bid, sid, ordering, numImage);

    final response = await client.post(
        imageListCategoryByScheduleApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: imageListCategoryByScheduleApiJsonParser.getData()
    );
    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return ImageListCategoryModel.fromJson(jsonDecode(jsonDecode(utf8.decode(response.bodyBytes))));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<BiasListModel> fetchBiasList(
      String uid) async {
    BiasListApiJsonParser biasListApiJsonParser= BiasListApiJsonParser(this.biasListEndpoint);
    biasListApiJsonParser.setHeader(uid, this.biasListEndpoint);
    biasListApiJsonParser.makeBodyData(uid);

    final response = await client.post(
        biasListApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: biasListApiJsonParser.getData()
    );

    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return BiasListModel.fromJson(jsonDecode(jsonDecode(utf8.decode(response.bodyBytes))));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
