import 'package:cheese/src/bloc/sign_bloc/sign_state.dart';
import "package:cheese/src/model/sign_model.dart";
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:cheese/src/resources/main_json_parser.dart';
import 'package:cheese/src/data_domain/data_domain.dart';

class PasswordChangeApiJsonParser extends MainJsonParser{
  final Map body = {
    'email' : '',
    'password':'',
  };
  Uri __url = Uri();

  PasswordChangeApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(email,password){
    body['email'] = email;
    body['password'] = password;
  }

  String getData() => super.makeSendData(this.body);

  Uri getUri() => this.__url;
}

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

class TryLoginApiJsonParser extends MainJsonParser{
  final Map body = {
    'email' : '',
    'password' : '',
  };
  Uri __url = Uri();

  TryLoginApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(email, password){
    body['email'] = email;
    body['password'] = password;
  }

  String getData() => super.makeSendData(this.body);

  Uri getUri() => this.__url;
}

class TrySignUpApiJsonParser extends MainJsonParser{
  final Map body = {
    'email' : '',
    'uname' : '',
    'password' : '',
    'nickname' : '',
    'birthday' : '',
  };
  Uri __url = Uri();

  TrySignUpApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(User user){
    body['email'] = user.email;
    body['uname'] = user.uname;
    body['password'] = user.password;
    body['nickname'] = user.nickname;
    body['birthday'] = user.birthday;
  }

  String getData() => super.makeSendData(this.body);

  Uri getUri() => this.__url;
}


class SignNetworkProvider{
  final String searchEmailEndpoint = '/sign_system/try_search_email';
  final String sendEmailEndpoint = '/sign_system/try_send_email';
  final String trySignUpEndpoint = '/sign_system/try_sign_up';
  final String tryLoginEndpoint = '/sign_system/try_login';
  final String passwordChangeEndpoint = '/sign_system/try_password_change';

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
      return SearchEmailModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<SendEmailModel> fetchTrySendEmail(String email) async {
    TrySearchEmailApiJsonParser trySearchEmailApiJsonParser = TrySearchEmailApiJsonParser(this.sendEmailEndpoint);
    trySearchEmailApiJsonParser.setHeader("", this.sendEmailEndpoint);
    trySearchEmailApiJsonParser.makeBodyData(email);

    final response = await client.post(
        trySearchEmailApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: trySearchEmailApiJsonParser.getData()
    );

    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return SendEmailModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<TryLoginModel> fetchTryLogin(String email, String password) async {

    TryLoginApiJsonParser tryLoginApiJsonParser = TryLoginApiJsonParser(this.tryLoginEndpoint);
    tryLoginApiJsonParser.setHeader("", this.tryLoginEndpoint);
    tryLoginApiJsonParser.makeBodyData(email, password);

    final response = await client.post(
        tryLoginApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: tryLoginApiJsonParser.getData()
    );

    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return TryLoginModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<PasswordChangeModel> fetchPasswordChange(String email, String password) async {

    PasswordChangeApiJsonParser passwordChangeApiJsonParser = PasswordChangeApiJsonParser(this.passwordChangeEndpoint);
    PasswordChangeApiJsonParser.setHeader("", this.passwordChangeEndpoint);
    passwordChangeApiJsonParser.makeBodyData(email, password);

    final response = await client.post(
        passwordChangeApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: passwordChangeApiJsonParser.getData()
    );

    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return PasswordChangeModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<TrySignUpModel> fetchTrySignUp(
      User user,
      ) async {
    TrySignUpApiJsonParser trySignUpApiJsonParser = TrySignUpApiJsonParser(this.trySignUpEndpoint);
    trySignUpApiJsonParser.setHeader("", this.trySignUpEndpoint);
    trySignUpApiJsonParser.makeBodyData(user);

    final response = await client.post(
        trySignUpApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: trySignUpApiJsonParser.getData()
    );

    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return TrySignUpModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load post');
    }
  }

/*
  Future<TryLoginModel> fetchTryLogin(String email, String password) async {
    TryLoginApiJsonParser tryLoginApiJsonParser = TryLoginApiJsonParser(this.tryLoginEndpoint);
    tryLoginApiJsonParser.setHeader("", this.tryLoginEndpoint);
    tryLoginApiJsonParser.makeBodyData(email, password);

    final response = await client.post(
        tryLoginApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: tryLoginApiJsonParser.getData()
    );

    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return TryLoginModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load post');
    }
  }

 */

}


