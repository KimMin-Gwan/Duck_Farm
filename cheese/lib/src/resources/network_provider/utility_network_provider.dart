//import 'dart:developer';
import 'package:cheese/src/data_domain/data_domain.dart';
import 'package:cheese/src/model/utility_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:cheese/src/resources/main_json_parser.dart';

class SearchApiJsonParser extends MainJsonParser{
  final Map body = {
    'keyword' : '',
  };
  Uri __url = Uri();

  SearchApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(String keyword){
    body['keyword'] = keyword;
  }

  String getData() => super.makeSendData(body);

  Uri getUri() => __url;
}

class FollowBiasApiJsonParser extends MainJsonParser{
  final Map body = {
    'uid' : '',
    'bid' : '',
  };
  Uri __url = Uri();

  FollowBiasApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(String uid, String bid){
    body['uid'] = uid;
    body['bid'] = bid;
  }

  String getData() => super.makeSendData(body);

  Uri getUri() => __url;
}




class UtilityNetworkProvider {
  final String searchBiasEndpoint = '/utility_system/search_bias';
  final String searchScheduleEndpoint = '/utility_system/search_schedule';
  final String followBiasEndpoint= '/utility_system/follow_bias';
  Client client = Client();

  Future<SearchBiasModel> fetchSearchBias(String keyword) async {
    SearchApiJsonParser searchBiasApiJsonParser = SearchApiJsonParser(
        searchBiasEndpoint);
    searchBiasApiJsonParser.setHeader("", searchBiasEndpoint);
    searchBiasApiJsonParser.makeBodyData(keyword);

    final response = await client.post(
        searchBiasApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: searchBiasApiJsonParser.getData()
    );
    //log('request status: ${response.statusCode}');
    print('request status: ${response.statusCode}');

    if (response.statusCode == 200) {
      return SearchBiasModel.fromJson(
          jsonDecode(jsonDecode(utf8.decode(response.bodyBytes))));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<User> fetchFollowBias(String uid, String bid) async {
    FollowBiasApiJsonParser followBiasApiJsonParser = FollowBiasApiJsonParser(
        followBiasEndpoint);
    followBiasApiJsonParser.setHeader(uid, followBiasEndpoint);
    followBiasApiJsonParser.makeBodyData(uid, bid);

    final response = await client.post(
        followBiasApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: followBiasApiJsonParser.getData()
    );
    //log('request status: ${response.statusCode}');
    print('request status: ${response.statusCode}');

    if (response.statusCode == 200) {
      return User.fromJson(
          jsonDecode(jsonDecode(utf8.decode(response.bodyBytes))));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<SearchScheduleModel> fetchSearchSchedule(String keyword) async {
    SearchApiJsonParser searchScheduleApiJsonParser = SearchApiJsonParser(
        searchBiasEndpoint);
    searchScheduleApiJsonParser.setHeader("", searchBiasEndpoint);
    searchScheduleApiJsonParser.makeBodyData(keyword);

    final response = await client.post(
        searchScheduleApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: searchScheduleApiJsonParser.getData()
    );
    //log('request status: ${response.statusCode}');
    print('request status: ${response.statusCode}');

    if (response.statusCode == 200) {
      return SearchScheduleModel.fromJson(
          jsonDecode(jsonDecode(utf8.decode(response.bodyBytes))));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
