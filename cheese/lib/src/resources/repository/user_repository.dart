import 'package:cheese/src/resources/network_provider/sign_network_provider.dart';
import 'package:cheese/src/model/sign_model.dart';
import 'package:cheese/src/data_domain/data_domain.dart';

class UserRepository{
  final SignNetworkProvider signNetworkProvider = SignNetworkProvider();
  User user = User(uid: '1234-abcd-5678');

  Future<SearchEmailModel> fetchSearchEmail(email) => signNetworkProvider.fetchSearchEmail(email);
  Future<SendEmailModel> fetchTrySendEmail(email) => signNetworkProvider.fetchTrySendEmail(email);
  //Future<TryLoginModel> fetchTryLogin(email, password) => signNetworkProvider.fetchTryLogin(email, password);
  Future<TrySignUpModel> fetchTrySignUp(user) => signNetworkProvider.fetchTrySignUp(user);
  Future<TryLoginModel> fetchTryLogin(email, password) => signNetworkProvider.fetchTryLogin(email, password);
  Future<PasswordChangeModel>fetchPasswordChange(email,password)=>signNetworkProvider.fetchPasswordChange(email, password);

  void setUser(self, User user){
    this.user = user;
  }

}