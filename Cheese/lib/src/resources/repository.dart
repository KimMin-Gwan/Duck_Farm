import 'dart:async';
import 'package:cheese/src/resources/user_api_provider.dart';
import 'package:cheese/src/models/user_model.dart';

// 로그인을 위한 레포지토리
class signRepository {
  final signApiProvider = SignApiProvider();
  String _email = "";
  String _password = "";


  setEmailPassword(email, password){
    _email = email;
    _password = password;
  }

  Future<SignInModel> fetchSign() => signApiProvider.fetchSignData(_email, _password);

}

/*
class userRepository {
  final userApiProvider = UserApiProvider();

  Future<UserModel> fetchUser() => userApiProvider.fetchUserData();

}
 */