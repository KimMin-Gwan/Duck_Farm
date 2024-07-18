import 'package:cheese/src/data_domain/data_domain.dart';

abstract class SampleModel {
  final String stateCode;
  SampleModel(this.stateCode);
}


class SearchEmailModel extends SampleModel {
  final bool flag;

  SearchEmailModel({
    required String stateCode,
    required this.flag,
  }) : super(stateCode);

  factory SearchEmailModel.fromJson(Map data) {
    return SearchEmailModel(
      stateCode: data['header']['state-code'],
      flag: data['body']['flag'],
    );
  }
}


class SendEmailModel extends SampleModel{
  final bool flag;

  SendEmailModel({
    required String stateCode,
    required this.flag
  }):super(stateCode);

  factory SendEmailModel.fromJson(Map data){
    return SendEmailModel(
      stateCode: data['header']['state-code'],
      flag: data['body']['flag'],
    );
  }
}

class TryLoginModel extends SampleModel{
  final User user;
  final bool result;

  TryLoginModel({
    required String stateCode,
    required this.user,
    required this.result
  }):super(stateCode);

  factory TryLoginModel.fromJson(Map data){
    User user = User();
    user.makeWithDict(data['body']['user']);

    return TryLoginModel(
      stateCode: data['header']['state-code'],
      user: user,
      result: data['body']['result']
    );
  }
}

class TrySignUpModel extends SampleModel{
  final User user;

  TrySignUpModel({
    required String stateCode,
    required this.user,
  }):super(stateCode);

  factory TrySignUpModel.fromJson(Map data){
    User user = User();
    user.makeWithDict(data['body']['user']);

    return TrySignUpModel(
      stateCode: data['header']['state-code'],
      user: user
    );
  }
}


/*
class TryLoginModel extends SampleModel{
  final User user;
  final bool result;

  TryLoginModel({
    required String stateCode,
    required this.user,
    required this.result
  }):super(stateCode);

  factory TryLoginModel.fromJson(Map data){
    User user = User();
    user.makeWithDict(data['body']['user']);

    return TryLoginModel(
      stateCode: data['header']['state-code'],
      user: user,
      result: data['body']['result']
    );
  }
}

 */
