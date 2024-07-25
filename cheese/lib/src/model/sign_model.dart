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
    print("in search email model ");
    print(data);
    return SearchEmailModel(
      stateCode: data['header']['state-code'],
      flag: data['body']['result'],
    );
  }
}

class PasswordChangeModel extends SampleModel {
  final bool flag;

  PasswordChangeModel({
    required String stateCode,
    required this.flag,
  }) : super(stateCode);

  factory PasswordChangeModel.fromJson(Map data) {
    return PasswordChangeModel(
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
    print(data);
    return SendEmailModel(
      stateCode: data['header']['state-code'],
      flag: data['body']['result'],
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
