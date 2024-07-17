import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_event.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_state.dart';
import 'package:cheese/src/resources/user_repository.dart';
import 'package:cheese/src/data_domain/data_domain.dart';
import 'package:cheese/src/model/sign_model.dart';




class SignBloc extends Bloc<SignEvent, SignState>{
  final UserRepository _userRepository;
  final List<SignState> _signeStateStack = [];
  final User _user = User();

  SignBloc(this._userRepository) : super(InitSignState()){
    on<EmailInputEvent>(_onEmailInputEvent);
  }

  Future<void> _onEmailInputEvent(EmailInputEvent event, Emitter<SignState> emit) async {
    _user.email = event.email;
    bool flag = false;
    SignState state;

    SearchEmailModel searchEmailModel = await _userRepository.fetchSearchEmail(_user.email);
    flag = searchEmailModel.flag;
    if (flag){
      state = TryLoginState(_user.email);
    }else{
      state = TrySendEmailState();
    }
    _signeStateStack.add(state);
    emit(state);
  }



}