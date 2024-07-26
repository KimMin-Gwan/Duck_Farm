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
  CoreEvent latestEvent = InitCoreEvent();
  bool _refreshFlag = false;
  CoreState _state = StartMainServiceState();
  String targetBid = "";

  CoreBloc(this._userRepository, this._coreRepository) : super(StartMainServiceState()){
    on<StartMainServiceEvent>(_onStartMainServiceEvent);
    on<NoneBiasHomeDataEvent>(_onNoneBiasHomeDataEvent);
    on<BiasHomeDataEvent>(_onBiasHomeDataEvent);
    on<DetailImageDataEvent>(_onDetailImageEvent);
    on<ImageListCategoryEvent>(_onImageListCategoryEvent);
    on<ImageListCategoryByScheduleEvent>(_onImageListCategoryByScheduleEvent);
    on<ImageSearchEvent>(_onImageSearchEvent);
    on<LoadBackwardEvent>(_onLoadBackwardEvent);
    on<BiasListEvent>(_onBiasListEvent);
    on<CoreRefreshEvent>(_onCoreRefreshEvent);
  }

  Future<void> _onStartMainServiceEvent(StartMainServiceEvent event, Emitter<CoreState> emit) async {
    latestEvent = event;
    _state = StartMainServiceState();
    if(!_refreshFlag){
      _coreStateStack.add(_state);
    }
    _refreshFlag = false;
    emit(_state);
  }


  Future<void> _onBiasListEvent(BiasListEvent event, Emitter<CoreState> emit) async {
    latestEvent = event;
    BiasListModel biasListModel = await _coreRepository.fetchBiasList(_userRepository.user.uid);
    _state = BiasListState(biasListModel);
    if(!_refreshFlag){
      _coreStateStack.add(_state);
    }
    _refreshFlag = false;
    emit(_state);
  }

  Future<void> _onNoneBiasHomeDataEvent(NoneBiasHomeDataEvent event, Emitter<CoreState> emit) async {
    targetBid = "";
    latestEvent = event;
    HomeDataModel homeDataModel = await _coreRepository.fetchNoneBiasHomeData(_userRepository.user.uid, event.date);
    _state = NoneBiasState(homeDataModel, event.date);
    if(!_refreshFlag){
      _coreStateStack.add(_state);
    }
    _refreshFlag = false;
    emit(_state);
  }

  Future<void> _onBiasHomeDataEvent(BiasHomeDataEvent event, Emitter<CoreState> emit) async {
    if (_state is BiasState){
      if(targetBid == event.bid && event.initFlag){
        add(NoneBiasHomeDataEvent.none_date());
        return;
      }
    }
    latestEvent = event;
    HomeDataModel homeDataModel = await _coreRepository
        .fetchBiasHomeData(_userRepository.user.uid, event.date, event.bid);
    CoreState state = BiasState(homeDataModel, event.date, event.bid);
    if(!_refreshFlag || _state is! BiasState){
      _coreStateStack.add(state);
    }
    targetBid = event.bid;
    _state = state;
    _refreshFlag = false;
    emit(state);
  }

  Future<void> _onDetailImageEvent(DetailImageDataEvent event, Emitter<CoreState> emit) async {
    latestEvent = event;
    String iid = event.iid;
    DetailImageModel detailImageModel = await _coreRepository.fetchDetailImageData(_userRepository.user.uid, iid);

    _state = DetailImageState(detailImageModel);
    if(!_refreshFlag){
      _coreStateStack.add(_state);
    }
    _refreshFlag = false;
    emit(_state);
  }

  Future<void> _onImageListCategoryEvent(ImageListCategoryEvent event, Emitter<CoreState> emit) async {
    latestEvent = event;
    String bid = event.bid;
    String ordering = event.ordering;

    ImageListCategoryModel imageListCategoryModel =
    await _coreRepository.fetchImageListCategory(
        _userRepository.user.uid, bid, ordering, numImage);

    numImage = imageListCategoryModel.numImage;

    _state = ImageListCategoryState(imageListCategoryModel);
    if(!_refreshFlag){
      _coreStateStack.add(_state);
    }
    _refreshFlag = false;
    emit(_state);
  }

  Future<void> _onImageListCategoryByScheduleEvent(ImageListCategoryByScheduleEvent event, Emitter<CoreState> emit) async {
    latestEvent = event;
    String bid = event.bid;
    String sid = event.sid;
    String ordering = event.ordering;

    ImageListCategoryModel imageListCategoryModel = await _coreRepository.fetchImageListCategoryBySchedule(
        _userRepository.user.uid, bid, sid, ordering, numImage);
    _state = ImageListCategoryByScheduleState(imageListCategoryModel);
    if(!_refreshFlag){
      _coreStateStack.add(_state);
    }
    _refreshFlag = false;
    emit(_state);
  }

  Future<void> _onImageSearchEvent(ImageSearchEvent event, Emitter<CoreState> emit) async {
    String keyword= event.keyword;
    String ordering = event.ordering;

    ImageSearchModel imageSearchModel=
    await _coreRepository.fetchImageSearch(
        _userRepository.user.uid, keyword, ordering, numImage);

    numImage = imageSearchModel.numImage;

    _state = ImageSearchState(imageSearchModel);
    emit(_state);
  }

  Future<void> _onLoadBackwardEvent(LoadBackwardEvent event, Emitter<CoreState> emit) async {
    latestEvent = event;
    numImage = 0;

    //print(_coreStateStack);
    _coreStateStack.removeLast();
    if (!_coreStateStack.isEmpty){
      if (_coreStateStack.last is NoneBiasState){
        add(NoneBiasHomeDataEvent.none_date());
      }
      _state = _coreStateStack.last;
      emit(_state);
    }else{
      emit(StartMainServiceState());
    }
  }

  Future<void> _onCoreRefreshEvent(CoreRefreshEvent event, Emitter<CoreState> emit) async {
    print("Refreshing");
    _refreshFlag = true;
    add(latestEvent);
  }
}





