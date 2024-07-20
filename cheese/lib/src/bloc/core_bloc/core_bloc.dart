import 'package:cheese/src/model/home_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/resources/user_repository.dart';
import 'package:cheese/src/model/image_model.dart';
import 'package:cheese/src/resources/core_repository.dart';
import 'package:cheese/src/model/bias_model.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState>{
  final UserRepository _userRepository;
  final CoreRepository _coreRepository;
  final List<CoreState> _coreStateStack = [];

  String selectedBid = "";

  CoreBloc(this._userRepository, this._coreRepository) : super(InitCoreState()){
    on<NoneBiasHomeDataEvent>(_onNoneBiasHomeDataEvent);
    on<DetailImageDataEvent>(_onDetailImageEvent);
    on<ImageListCategoryEvent>(_onImageListCategoryEvent);
    on<ImageListCategoryByScheduleEvent>(_onImageListCategoryByScheduleEvent);
    on<LoadBackwardEvent>(_onLoadBackwardEvent);
    on<BiasListEvent>(_onBiasListEvent);
  }

  /*
  void _onInitHomePage(Emitter<CoreState> emit) async{
    UserModel userModel = await _userRepository.fetchUserData();
    _userRepository.setUserModel(userModel);
    add(NoneBiasHomeDataEvent(_userRepository.getUserModel()));
  }
   */

  Future<void> _onBiasListEvent(BiasListEvent event, Emitter<CoreState> emit) async {
    String bid =event.bid;
    BiasListModel biasListModel = await _coreRepository.fetchBiasList(_userRepository.uid, bid);
    var state = BiasListState(biasListModel);
    _coreStateStack.add(state);
    emit(state);
  }

  Future<void> _onNoneBiasHomeDataEvent(NoneBiasHomeDataEvent event, Emitter<CoreState> emit) async {
    HomeDataModel homeDataModel = await _coreRepository.fetchNoneBiasHomeData(_userRepository.uid, event.date);
    var state = NoneBiasState(homeDataModel, event.date);
    _coreStateStack.add(state);
    emit(state);
  }

  Future<void> _onDetailImageEvent(DetailImageDataEvent event, Emitter<CoreState> emit) async {
    String iid = event.iid;
    DetailImageModel detailImageModel = await _coreRepository.fetchDetailImageData(_userRepository.uid, iid);

    var state = DetailImageState(detailImageModel);
    _coreStateStack.add(state);
    emit(state);
  }

  Future<void> _onImageListCategoryEvent(ImageListCategoryEvent event, Emitter<CoreState> emit) async {
    String bid = event.bid;

    ImageListCategoryModel imageListCategoryModel = await _coreRepository.fetchImageListCategory(_userRepository.uid, bid);
    var state = ImageListCategoryState(imageListCategoryModel);
    _coreStateStack.add(state);
    emit(state);
  }

  Future<void> _onImageListCategoryByScheduleEvent(ImageListCategoryByScheduleEvent event, Emitter<CoreState> emit) async {
    String bid = event.bid;
    String sid = event.sid;

    ImageListCategoryModel imageListCategoryModel = await _coreRepository.fetchImageListCategoryBySchedule(_userRepository.uid, bid, sid);
    var state = ImageListCategoryByScheduleState(imageListCategoryModel);
    _coreStateStack.add(state);
    emit(state);
  }

  Future<void> _onLoadBackwardEvent(LoadBackwardEvent event, Emitter<CoreState> emit) async {
    _coreStateStack.removeLast();
    if (!_coreStateStack.isEmpty){
      emit(_coreStateStack.last);
    }else{
      emit(InitCoreState());
    }
  }
}





