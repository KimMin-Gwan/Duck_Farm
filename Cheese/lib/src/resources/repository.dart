import 'dart:async';
import 'package:cheese/src/resources/user_api_provider.dart';
import 'package:cheese/src/models/user_model.dart';

// 로그인을 위한 레포지토리
class SignInRepository {
  final signApiProvider = SignInApiProvider();
  String _email = "";
  String _password = "";


  setEmailPassword(email, password){
    _email = email;
    _password = password;
  }

  Future<SignInModel> fetchSign() => signApiProvider.fetchSignData(_email, _password);
}

// 회원가입을 위한 레포지토리
class SignUpRepository{
  final signApiProvider = SignUpApiProvider();
  String _email = "";
  String _birthday = "";
  String _sex = "none";
  String _password = "";
  int _otp = 0;

  setEmail(email){_email = email;}
  setPassword(password){_password = password;}
  setBirthday(birthday){_birthday= birthday;}
  setSex(sex){_sex = sex;}
  setOtp(otp){_otp = otp;}


  // 서버 펫쳐
  Future<SignUpModel> fetchEmailSign() => signApiProvider.fetchEmailData(_email);
  Future<SignUpModel> fetchOtpData() => signApiProvider.fetchOtpData(_email, _otp);
  Future<SignUpModel> fetchUserData() => signApiProvider.fetchUserData(_email, _birthday, _sex, _password);

}
