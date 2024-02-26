import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:cheese/src/models/user_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class JsonParser {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  String _server_url = "http://127.0.0.1";
  String _version = "";
  Map _header = {};

  JsonParser(){
    _initPackageInfo();
    _header = {
      'Version' : _version,
      'Date' : DateTime.now().toString(),
      'Action' : 'default',
      'Content-Type' : 'application/json',
      'User' : {'login' : 0, 'UID' : 0},
    };
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    _packageInfo = info;
    _version = _packageInfo.version;
  }

  /*
  // 헤더 설정
  // action : String, user : 로그인되면 1, 아니면 0, UID: Int
   */
  setHeader(String action, {user = 0, UID = 0}){
    _header['Action'] = action;
    _header['User']["login"] = user;
    _header['User']["UID"] = UID;
  }

  // 보내기 가능한 형태로 변경 => json 데이터
  // body는 각 자식 클래스에서 메서드로 생성할것
  dataParsing (Map body){
    Map Data = {
      'header' : _header,
      'body' : body
    };
    var jsonData = json.encode(Data);
    return jsonData;
  }

  // header 받기
  //Map getHeader() => {"Content-Type" : "application/json"};

  // 서버 url 받기
  getUrl() => _server_url;
}

