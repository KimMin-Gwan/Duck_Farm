import 'package:cheese/src/model/user_model.dart';
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:cheese/src/resources/main_json_parser.dart';


class UserApiJsonParser extends MainJsonParser{
  final Map body = {};
  Uri __url = Uri();

  UserApiJsonParser(String endpoint):super(){
    __url = Uri(
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  Map<String, dynamic> getData() => super.makeSendData(this.body);

  Uri getUri() => this.__url;
}


class UserNetworkProvider{
  final String endpoint = "/user/get_user_data";
  Client client = Client();

  Future<UserModel> fetchUserData(String uid) async {
    UserApiJsonParser userApiJsonParser = UserApiJsonParser(this.endpoint);
    userApiJsonParser.setHeader(uid, endpoint);

    final response = await client.post(
        userApiJsonParser.getUri(),
        headers: {"Content-Type": "application/json"},
        body: userApiJsonParser.getData()
    );
    print("request status: ${response.statusCode}");
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

}