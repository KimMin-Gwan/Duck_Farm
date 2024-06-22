import 'package:cheese/src/model/home_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/resources/user_repository.dart';
import 'package:cheese/src/model/user_model.dart';
import 'package:cheese/src/model/image_model.dart';
import 'package:cheese/src/model/schedule_model.dart';
import 'package:cheese/src/model/bias_model.dart';
import 'package:cheese/src/resources/core_repository.dart';
import 'package:intl/intl.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState>{
  final UserRepository _userRepository;
  final CoreRepository _coreRepository;
  String selectedBid = "";

  CoreBloc(this._userRepository, this._coreRepository) : super(InitCoreState()){
    on<NoneBiasHomeDataEvent>(_onNoneBiasHomeDataEvent);
    on<DetailImageDataEvent>(_onDetailImageEvent);
    on<ImageListByCategory>(_onImageListByCategory);
  }

  /*
  void _onInitHomePage(Emitter<CoreState> emit) async{
    UserModel userModel = await _userRepository.fetchUserData();
    _userRepository.setUserModel(userModel);
    add(NoneBiasHomeDataEvent(_userRepository.getUserModel()));
  }
   */

  Future<void> _onNoneBiasHomeDataEvent(NoneBiasHomeDataEvent event, Emitter<CoreState> emit) async {
    HomeDataModel homeDataModel = await _coreRepository.fetchNoneBiasHomeData(_userRepository.uid, event.date);
    emit(NoneBiasState(homeDataModel, event.date));
  }

  Future<void> _onDetailImageEvent(DetailImageDataEvent event, Emitter<CoreState> emit) async {
    String iid_with_type = event.iid;
    String iid = iid_with_type.split('.').first;

    DetailImageModel detailImageModel = await _coreRepository.fetchDetailImageData(_userRepository.uid, iid);
    emit((DetailImageState(detailImageModel)));
  }

  Future<void> _onImageListByCategory(ImageListByCategory event, Emitter<CoreState> emit) async {
    String iid_with_type = event.bid;
    String iid = iid_with_type.split('.').first;

    DetailImageModel detailImageModel = await _coreRepository.fetchDetailImageData(_userRepository.uid, iid);
    emit((DetailImageState(detailImageModel)));
  }

}





