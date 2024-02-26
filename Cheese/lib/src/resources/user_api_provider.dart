import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:cheese/src/models/user_model.dart';
import 'package:cheese/src/resources/api_provider.dart';

class SignJsonParser extends JsonParser{
  Map _body = {};
  String _url = "";
  SignJsonParser(): super() {
    String _url = super.getUrl() + "/login";
    _body = {
      "email" : "",
      "password" : "",
    };
  }

  // email : Str, password : Str
  setBody(String email, String password){
    _body["email"] = email;
    _body["password"] = password;
    setHeader("login");
    return dataParsing(_body);
  }

  @override
  getUrl() => _url;
}


class SignApiProvider {
  SignJsonParser signJsonParser = SignJsonParser();
  Client client = Client();

  Future<SignInModel> fetchSignData(email, password) async {
    print("Trying to request Sign");
    var body = signJsonParser.setBody(email, password);
    final response = await client.post(
      signJsonParser.getUrl(),
      headers: {"Content-Type": "application/json"},
      body: body
    );
    print("request status: ${response.statusCode}");
    if (response.statusCode == 200) {
      return SignInModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}




class UserApiProvider {
  Client client = Client();

/*
  Future<UserModel> fetchUserData() async {
    print("get user data");
    final response = await client.get("http://www.naver.com");
    print(response.body.toString());
    if (response.statusCode == 200){
      return UserModel.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Failed to load post');
    }

  }
     */
}

