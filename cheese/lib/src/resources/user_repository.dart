import 'package:cheese/src/model/user_model.dart';
import 'package:cheese/src/resources/sign_network_provider.dart';
import 'package:cheese/src/resources/user_network_provider.dart';
import 'package:cheese/src/model/sign_model.dart';

class UserRepository{
  final SignNetworkProvider signNetworkProvider = SignNetworkProvider();
  final String uid = '1234-abcd-5678';

  Future<SearchEmailModel> fetchSearchEmail(email) => signNetworkProvider.fetchSearchEmail(email);
  Future<SendEmailModel> fetchTrySendEmail(email) => signNetworkProvider.fetchTrySendEmail(email);
  //Future<TryLoginModel> fetchTryLogin(email, password) => signNetworkProvider.fetchTryLogin(email, password);
  Future<TrySignUpModel> fetchTrySignUp(user) => signNetworkProvider.fetchTrySignUp(user);
  Future<TryLoginModel> fetchTryLogin(email, password) => signNetworkProvider.fetchTryLogin(email, password);



}