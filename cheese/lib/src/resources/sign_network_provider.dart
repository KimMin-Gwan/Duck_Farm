import "package:cheese/src/model/sign_model.dart";
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:cheese/src/resources/main_json_parser.dart';

class TrySearchEmailApiJsonParser extends MainJsonParser{
  final Map body = {
    'email' : '',
  };
  Uri __url = Uri();

  TrySearchEmailApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(email){
    body['email'] = email;
  }

  String getData() => super.makeSendData(this.body);

  Uri getUri() => this.__url;
}

class SignNetworkProvider{
  final String searchEmailEndpoint = '/sign_system/try_search_email';
  Client client = Client();

  Future<SearchEmailModel> fetchSearchEmail(String email) async {
    TrySearchEmailApiJsonParser trySearchEmailApiJsonParser = TrySearchEmailApiJsonParser(this.searchEmailEndpoint);
    trySearchEmailApiJsonParser.setHeader("", this.searchEmailEndpoint);
    trySearchEmailApiJsonParser.makeBodyData(email);

    final response = await client.post(
      trySearchEmailApiJsonParser.getUri(),
      headers: {'Content-Type': 'application/json'},
      body: trySearchEmailApiJsonParser.getData()
    );
    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return SearchEmailModel.fromJson(jsonDecode(jsonDecode(utf8.decode(response.bodyBytes))));
    } else {
      throw Exception('Failed to load post');
  }
}



}


