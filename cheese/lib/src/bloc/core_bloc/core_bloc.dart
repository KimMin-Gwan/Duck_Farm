import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/resources/user_repository.dart';
import 'package:cheese/src/model/user_model.dart';
import 'package:cheese/src/model/image_model.dart';
import 'package:cheese/src/model/schedule_model.dart';
import 'package:cheese/src/model/bias_model.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState>{
  final UserRepository _userRepository;

  CoreBloc(this._userRepository) : super(InitCoreState()){
    on<NoneBiasHomeDataEvent>(_onNoneBiasHomeDataEvent);
  }

  void _onInitHomePage(Emitter<CoreState> emit) async{
    UserModel userModel = await _userRepository.fetchUserData();
    _userRepository.setUserModel(userModel);
    add(NoneBiasHomeDataEvent(_userRepository.getUserModel()));
  }

  void _onNoneBiasHomeDataEvent(NoneBiasHomeDataEvent event, Emitter<CoreState> emit){

  }

}





