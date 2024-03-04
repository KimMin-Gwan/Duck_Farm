import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cheese/src/bloc/user_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FindEmailModel{
  bool _result = false;

  FindEmailModel.fromJson(Data){
    var header = Data['header'];
    var body = Data['body'];
    _result = body['status'];
  }

  getResult() => _result;
}

/* //회원가입 json 형태
Map json_data = {
  'header' : {
    'version' : '0.1',
    'date' : 'yy/mm/dd',
    'action' : 'login',
    'content-type': 'application/json'
  },
  'body' : {
    'user' :{
      'uid' : 0,
      'email' : "email@email.com",
      'password' : "password",
      'birthday' : "yy/mm/dd",
      'sex' : 'male',
      'nickname' : 'nick'
    },
    'status' : '0', // 0이면 실패
    'about' : 'tips' // 전송 데이터의 상태
  }
};
 */

// 회원가입에 사용되는 모델
class SignUpModel{
  bool status = false;
  User _user = User();
  String detail = "Not yet"; //uid 또는 현재 전송 상태 정보
  static final storage = FlutterSecureStorage();

  SignUpModel.fromJson(Data){
    status = true;
    var header = Data['header'];
    var body = Data['body'];

    if (header['action'] == 'sign_in_confirmed') {
      var userData = body['user'];
      _user.setUser(userData);

      var jsonData = jsonEncode(userData);
      storage.write(
          key: 'login',
          value: jsonData,);
      detail = body['uid'].toString();
    }//email을 전송 후에
    else if (header['action'] == 'otp_get') {
      detail = body['status']; //성공하면 1
    }// otp 확인 후에
    else if (header['action'] == 'otp_confirmed'){
      detail = body['status']; // 성공하면 1
    }  //에러 발생시
    else{
      detail = body['about'];
    }
  }

}

/* //회원가입 json 형태
Map json_data = {
  'header' : {
    'version' : '0.1',
    'date' : 'yy/mm/dd',
    'action' : 'login',
    'content-type': 'application/json'
  },
  'body' : {
    'user' :{
      'uid' : 0,
      'email' : "email@email.com",
      'password' : "password",
      'birthday' : "yy/mm/dd",
      'sex' : 'male',
      'nickname' : 'nick'
    },
    'status' : '0', // 0이면 실패
    'about' : 'tips' // 전송 데이터의 상태
  }
};
 */

// 로그인에 사용되는 모델
class SignInModel{
  bool status = false;
  User _user = User();
  String detail = ""; //uid 저장공간
  static final storage = FlutterSecureStorage();

  SignInModel.fromJson(Data){
    var body = Data['body']; //json의 바디 부분
    if (body['staus'] == 1){
      status = true;
      detail = body['user']['uid'].toString();
      var userData = body['user'];
      _user.setUser(userData);

      // 이건 왜?
      //String email = _user.getEmail();
      //String password = _user.getPassword();

      var jsonData = jsonEncode(userData);
      storage.write(
        key: 'login',
        value: jsonData,
      );
    }else{
      detail = body['about'];
      print(detail);
    }
  }
}

/* //로그인 json 형태
Map json_data = {
  'header' : {
    'version' : '0.1',
    'date' : 'yy/mm/dd',
    'action' : 'login',
    'content-type': 'application/json'
  },
  'body' : {
    'user' :{
      'uid' : 0,
      'email' : "email@email.com",
      'password' : "password",
      'birthday' : "yy/mm/dd",
      'sex' : 'male',
      'nickname' : 'nick'
    }
  }
};
 */




// 성별
enum Sex {none, male, female}
// 생일
class Birthday{
  int year = 0;
  int month = 0;
  int day = 0;
  // contructor
  setBirthday(y, m, d){year = y; month = m; day = d;}
}

// User 데이터 타입
class User{
  String _email = "";
  String _password = "";
  int _uid = 0;
  Sex _sex = Sex.none;
  Birthday _birthday = Birthday();
  String _nickname = "";


  // contructor
  setUser(userData){
    _email = userData['email'];
    _password = userData['password'];
    _uid = userData['uid'];
    if (userData == 'male'){_sex = Sex.male;}
    else if(userData == 'female'){_sex = Sex.female;}
    else{_sex = Sex.none;}
    _birthday = _birthday.setBirthday(userData['birthday']['year'],
        userData['birthday']['month'], userData['birthday']['day']);
    _nickname = userData['_nickname'];
  }

  // 접근자 모음
  getEmail() => _email;
  getPassword() => _password;
  getUid() => _uid;
  getSex() => _sex;
  getBirthday() => _birthday;
  getNickname() => _nickname;

  // 변경자 모음
  setEmail(String email){_email = email;}
  setPassword(String password){_password = password;}
  setUid(int uid){_uid = uid;}
  setSex(Sex sex){_sex = sex;}
  setNickname(String nickname){_nickname = nickname;}
}






