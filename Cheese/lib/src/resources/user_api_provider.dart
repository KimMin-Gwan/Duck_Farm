import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:cheese/src/models/user_model.dart';
import 'package:cheese/src/resources/api_provider.dart';

//로그인시도에서 사용되는 JSON 파서
class FindEmailJsonParser extends JsonParser{
  Map _body = {};
  String _url = "";

  FindEmailJsonParser(): super() {
    _url = getUrl() + "/find_email";
    _body = {
      "email" : "",
    };
  }

  //바디 세팅
  // email : Str, password : Str
  setBody(String email){
    _body["email"] = email;
    setHeader("find_email");
    return dataParsing(_body);
  }

  @override
  getUrl() => _url;
}

//서버로 로그인 시도
class FindEmailApiProvider {
 FindEmailJsonParser findEmailJsonParser = FindEmailJsonParser();
  Client client = Client();

  // email, password 전송
  Future<FindEmailModel> fetchEmailData(email) async {
    print("Trying to request find email");
    var body = findEmailJsonParser.setBody(email);
    final response = await client.post(
        findEmailJsonParser.getUrl(),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("request status: ${response.statusCode}");
    if (response.statusCode == 200) {
      return FindEmailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}

//로그인시도에서 사용되는 JSON 파서
class SignInJsonParser extends JsonParser{
  Map _body = {};
  String _url = "";
  SignInJsonParser(): super() {
    _url = getUrl() + "/login";
    _body = {
      "email" : "",
      "password" : "",
    };
  }

  //바디 세팅
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

//서버로 로그인 시도
class SignInApiProvider {
  SignInJsonParser signJsonParser = SignInJsonParser();
  Client client = Client();

  // email, password 전송
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

//로그인시도에서 사용되는 JSON 파서
class SignUpJsonParser extends JsonParser{
  Map _body = {};
  String _url = "";

  //Contructor
  SignUpJsonParser(): super() {
    _url = getUrl() + "/sign_up";
    _body = {
      "email" : "",
      "password" : "",
      "sex" : "",
      "birthday" : "",
      "otp" : 0,
    };
  }

  //바디 세팅
  // otp를 받기위해 Email을 보냄
  setBody2GetOtp(String email){
    _body["email"] = email;
    setHeader("get_otp");
    return dataParsing(_body);
  }

  // otp를 확인하기 위해 otp를 보냄
  setBody2ConfirmOtp(String email, int otp){
    _body["email"] = email;
    _body["otp"] = otp;
    setHeader("confirm_otp");
    return dataParsing(_body);
  }

  // 회원가입 전용 툴
  setBody(String email, String birthday, String sex, String password) {
    _body["email"] = email;
    _body['password'] = password;
    _body["birthday"] = birthday;
    _body["sex"] = sex;
    setHeader("sign_in");
    return dataParsing(_body);
  }

  // 비밀번호 교환 용
  setPassword(String password){
    _body['password'] = password;
    setHeader("change_password");
    return dataParsing(_body);
  }

  @override
  getUrl() => _url;
}

// 서버로 회원가입 시도
class SignUpApiProvider {
  SignUpJsonParser signJsonParser = SignUpJsonParser();
  Client client = Client();

  // otp 전송
  Future<SignUpModel> fetchEmailData(email) async {
    print("Trying to request otp");
    var body = signJsonParser.setBody2GetOtp(email);
    final response = await client.post(
        signJsonParser.getUrl(),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("request status: ${response.statusCode}");
    if (response.statusCode == 200) {
      return SignUpModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  // otp 전송
  Future<SignUpModel> fetchOtpData(email, otp) async {
    print("Trying to request otp");
    var body = signJsonParser.setBody2ConfirmOtp(email, otp);
    final response = await client.post(
        signJsonParser.getUrl(),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("request status: ${response.statusCode}");
    if (response.statusCode == 200) {
      return SignUpModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  // 회원가입 전송
  Future<SignUpModel> fetchUserData(email, birthday, sex, password) async {
    print("Trying to request otp");
    var body = signJsonParser.setBody(email, birthday, sex, password);
    final response = await client.post(
        signJsonParser.getUrl(),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("request status: ${response.statusCode}");
    if (response.statusCode == 200) {
      return SignUpModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}


