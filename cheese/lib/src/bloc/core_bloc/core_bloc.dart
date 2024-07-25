import 'package:cheese/src/model/home_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/resources/repository/user_repository.dart';
import 'package:cheese/src/model/image_model.dart';
import 'package:cheese/src/resources/repository/core_repository.dart';
import 'package:cheese/src/model/bias_model.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState>{
  final UserRepository _userRepository;
  final CoreRepository _coreRepository;
  final List<CoreState> _coreStateStack = [];
  int numImage = 0;
  String selectedBid = "";

  CoreBloc(this._userRepository, this._coreRepository) : super(StartMainServiceState()){
    on<StartMainServiceEvent>(_onStartMainServiceEvent);
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
  Future<void> _onStartMainServiceEvent(StartMainServiceEvent event, Emitter<CoreState> emit) async {
    CoreState state = StartMainServiceState();
    _coreStateStack.add(state);
    emit(state);
  }


  Future<void> _onBiasListEvent(BiasListEvent event, Emitter<CoreState> emit) async {
    BiasListModel biasListModel = await _coreRepository.fetchBiasList(_userRepository.user.uid);
    var state = BiasListState(biasListModel);
    _coreStateStack.add(state);
    emit(state);
  }

  Future<void> _onNoneBiasHomeDataEvent(NoneBiasHomeDataEvent event, Emitter<CoreState> emit) async {
    HomeDataModel homeDataModel = await _coreRepository.fetchNoneBiasHomeData(_userRepository.user.uid, event.date);
    var state = NoneBiasState(homeDataModel, event.date);
    _coreStateStack.add(state);
    emit(state);
  }

  Future<void> _onDetailImageEvent(DetailImageDataEvent event, Emitter<CoreState> emit) async {
    String iid = event.iid;
    DetailImageModel detailImageModel = await _coreRepository.fetchDetailImageData(_userRepository.user.uid, iid);

    var state = DetailImageState(detailImageModel);
    _coreStateStack.add(state);
    emit(state);
  }

  Future<void> _onImageListCategoryEvent(ImageListCategoryEvent event, Emitter<CoreState> emit) async {
    String bid = event.bid;
    String ordering = event.ordering;

    ImageListCategoryModel imageListCategoryModel =
    await _coreRepository.fetchImageListCategory(
        _userRepository.user.uid, bid, ordering, numImage);

    numImage = imageListCategoryModel.numImage;

    var state = ImageListCategoryState(imageListCategoryModel);
    _coreStateStack.add(state);
    emit(state);
  }

  Future<void> _onImageListCategoryByScheduleEvent(ImageListCategoryByScheduleEvent event, Emitter<CoreState> emit) async {
    String bid = event.bid;
    String sid = event.sid;
    String ordering = event.ordering;

    ImageListCategoryModel imageListCategoryModel = await _coreRepository.fetchImageListCategoryBySchedule(
        _userRepository.user.uid, bid, sid, ordering, numImage);
    var state = ImageListCategoryByScheduleState(imageListCategoryModel);
    _coreStateStack.add(state);
    emit(state);
  }

  Future<void> _onLoadBackwardEvent(LoadBackwardEvent event, Emitter<CoreState> emit) async {
    numImage = 0;
    print("hello");
    //print(_coreStateStack);
    _coreStateStack.removeLast();
    if (!_coreStateStack.isEmpty){
      if (_coreStateStack.last is NoneBiasState){
        add(NoneBiasHomeDataEvent.none_date());
      }
      emit(_coreStateStack.last);
    }else{
      emit(InitCoreState());
    }
  }
}





