import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cheese/src/bloc/user_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// User 관리에 사용되는 모델
class UserModel{
  _User _user = _User();

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['result'].length);
    _user = _user.setUser(parsedJson['result']['userData']);
  }

  getUser() => _user;
  setUser(userdata){_user.setUser(userdata);}
}

// 로그인에 사용되는 모델
class SignInModel{
  bool status = false;
  _User _user = _User();
  String detail = "Not yet";
  static final storage = FlutterSecureStorage();

  SignInModel.fromJson(Data){
    var body = Data['body'];
    if (body['staus'] == 1){
      status = true;
      detail = body['detail'];
      var userData = body['user'];
      _user.setUser(userData);

      String email = _user.getEmail();
      String password = _user.getPassword();

      var jsonData = jsonEncode(userData);
      storage.write(
        key: 'login',
        value: jsonData,
      );
    }else{
      detail = body['detail'];
    }

  }




}



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

class _User{
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


  getEmail() => _email;
  getPassword() => _password;
  getUid() => _uid;
  getSex() => _sex;
  getBirthday() => _birthday;
  getNickname() => _nickname;

  setEmail(String email){_email = email;}
  setPassword(String password){_password = password;}
  setUid(int uid){_uid = uid;}
  setSex(Sex sex){_sex = sex;}
  setNickname(String nickname){_nickname = nickname;}
}






