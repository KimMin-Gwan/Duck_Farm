import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_event.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_state.dart';
import 'package:cheese/src/resources/user_repository.dart';
import 'package:cheese/src/data_domain/data_domain.dart';
import 'package:cheese/src/model/sign_model.dart';


class SignBloc extends Bloc<SignEvent, SignState>{
  final UserRepository _userRepository;
  final List<SignState> _signStateStack = [];
  final User _user = User();

  SignBloc(this._userRepository) : super(InitSignState()){
    on<StartSignEvent>(_onStartSignEvent);
    on<EmailInputEvent>(_onEmailInputEvent);
    on<LoadBackwardEvent>(_onLoadBackwardEvent);
    on<TrySendEmailEvent>(_onTrySendEmailEvent);
    on<PasswordInputEvent>(_onPasswordInputEvent);
    on<NameBirthdayInputEvent>(_onNameBirthdayInputEvent);
    on<NicknameInputEvent>(_onNicknameInputEvent);
    on<CheckTermsEvent>(_onCheckTermInputEvent);
    on<EndOfSignUpEvent>(_onEndOfSignUpEvent);
    on<TryLoginEvent>(_onTryLoginEvent);
    on<PasswordChangeEvent>(_onPasswordChangeEvent);
  }

  Future<void> _onPasswordChangeEvent(PasswordChangeEvent event, Emitter<SignState> emit) async {
    String email = _user.email;
    String password =event.password;
    SignState state;
    PasswordChangeModel passwordChangeModel = await _userRepository.fetchPasswordChange(email,password);
    if (PasswordChangeModel.flag){
      state = TryLoginState(_user.email);
      _signStateStack.add(state);
      emit(state);
    }

  }

  Future<void> _onStartSignEvent(StartSignEvent event, Emitter<SignState> emit) async {
    emit(EmailInputState());
  }

  Future<void> _onTryLoginEvent(TryLoginEvent event, Emitter<SignState> emit) async {
    String email = event.email;
    String password = event.password;
    SignState state;

    TryLoginModel tryLoginModel = await _userRepository.fetchTryLogin(email, password);
    state = LoginSuccessState(tryLoginModel);

    _signStateStack.add(state);
    emit(state);
  }

  Future<void> _onLoadBackwardEvent(LoadBackwardEvent event, Emitter<SignState> emit) async {
    _signStateStack.removeLast();
    if (!_signStateStack.isEmpty){
      emit(_signStateStack.last);
    }else{
      emit(InitSignState());
    }
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
    _signStateStack.add(state);
    emit(state);
  }

  Future<void> _onTrySendEmailEvent(TrySendEmailEvent event, Emitter<SignState> emit) async {
    SignState state;

    SendEmailModel sendEmailModel = await _userRepository.fetchTrySendEmail(_user.email);

    state = PasswordInputState();
    _signStateStack.add(state);
    emit(state);
  }

  Future<void> _onPasswordInputEvent(PasswordInputEvent event, Emitter<SignState> emit) async {
    SignState state;

    state = NameBirthdayInputState();
    _signStateStack.add(state);
    emit(state);
  }

  Future<void> _onNameBirthdayInputEvent(NameBirthdayInputEvent event, Emitter<SignState> emit) async {
    SignState state;

    state = NicknameInputState();
    _signStateStack.add(state);
    emit(state);
  }

  Future<void> _onNicknameInputEvent(NicknameInputEvent event, Emitter<SignState> emit) async {
    SignState state;

    state = CheckTermsState();
    _signStateStack.add(state);
    emit(state);
  }

  Future<void> _onCheckTermInputEvent(CheckTermsEvent event, Emitter<SignState> emit) async {
    SignState state;

    state = EndOfSignUpState();
    _signStateStack.add(state);
    emit(state);
  }

  Future<void> _onEndOfSignUpEvent(EndOfSignUpEvent event, Emitter<SignState> emit) async {
    //SignState state;

    //state = InitSignState();
    //_signStateStack.add(state);
    //emit(state);
  }

}