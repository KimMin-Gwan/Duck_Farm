import 'dart:async';
import 'package:cheese/src/models/user_model.dart';
import 'package:cheese/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloC {
  final _repository = signRepository();
  final _signFetcher = PublishSubject<SignInModel>();

  // 로그인 시도
  String _email = "";
  RegExp _regex = RegExp(r'@[A-Za-z0-9_]{5,}.*\.[A-Za-z]{2,}');
  String _password = "";

  Stream<SignInModel> get signInModel => _signFetcher.stream;
  // 로그인 시도 결과
  String message = "";

  // Email 세팅
  // return 1이면 정상, return 0 이면 비정상
  setEmail(String email) {
    if (_regex.hasMatch(email)){
      _email = email;
      return 1;
    } else{
      return 0;
    }
  }

  // Email 세팅
  setPassword(String password) {
    if (_regex.hasMatch(password)) {
      _password = password;
      return 1;
    } else{
      return 0;
    }
  }

  // 서버에 로그인을 시도
  fetchSignIn() async {
    _repository.setEmailPassword(_email, _password);
    SignInModel signInModel = await _repository.fetchSign();
    _signFetcher.sink.add(signInModel);
  }

  // 삭제전용 함수
  dispose() {
    _signFetcher.close();
  }
}



