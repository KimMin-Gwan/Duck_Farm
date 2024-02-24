import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class User_Info{
  // 아직 명확하지 않는 데이터 타입
  final int uid;
  final String email;
  final String sex;
  final String birthday;
  final String nickname;

  User_Info(
    {
      required this.uid,
      required this.email,
      required this.sex,
      required this.birthday,
      required this.nickname,
    }
  );
  // 형식은 변경이 필요함
  factory User_Info.fromJson(Map<String, dynamic> json) {
    return User_Info(
      uid: json['uid'],
      email: json['email'],
      sex: json["sex"],
      birthday: json['birthday'],
      nickname: json['nickname'],
    );
  }
}





