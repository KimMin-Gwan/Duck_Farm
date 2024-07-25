import 'dart:io';

import 'package:cheese/src/data_domain/data_domain.dart';
import 'package:cheese/src/model/utility_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/utility_bloc/utility_event.dart';
import 'package:cheese/src/bloc/utility_bloc/utility_state.dart';
import 'package:cheese/src/resources/repository/user_repository.dart';
import 'package:cheese/src/resources/repository/utility_repository.dart';
//import 'package:cheese/src/resources/core_repository.dart';

class UtilityBloc extends Bloc<UtilityEvent, UtilityState> {
  final UserRepository _userRepository;
  final UtilityRepository _utilityRepository;
  //final CoreRepository _coreRepository;
  //final List<UtilityState> _coreStateStack = [];
  DateTime? _timing;

  UtilityBloc(this._userRepository, this._utilityRepository)
      : super(InitUtilityState()) {
    on<SearchBiasEvent>(_onSearchBiasEvent);
    on<SearchScheduleEvent>(_onSearchScheduleEvent);
    on<FollowBiasEvent>(_onFollowBiasEvent);
    on<InitUtilityEvent>(_onInitUtilityEvent);
  }

  Future<void> _onInitUtilityEvent(InitUtilityEvent event, Emitter<UtilityState> emit) async {
    InitUtilityState state = InitUtilityState();
    emit(state);
  }

  Future<void> _onSearchScheduleEvent(SearchScheduleEvent event, Emitter<UtilityState> emit) async {
    if (_executeFunction()){
      String keyword = event.keyword;

      SearchScheduleModel searchScheduleModel = await _utilityRepository.fetchSearchSchedule(keyword);
      UtilityState state = SearchScheduleState(searchScheduleModel);
      emit(state);
    }else{
      var duration = const Duration(milliseconds: 150);
      sleep(duration);
      return;
    }
  }

  Future<void> _onSearchBiasEvent(SearchBiasEvent event, Emitter<UtilityState> emit) async {
    if (_executeFunction()){
      String keyword = event.keyword;

      SearchBiasModel searchBiasModel = await _utilityRepository.fetchSearchBias(keyword);

      List<bool> followingFlag = [];
      for( Bias bias in searchBiasModel.biasList){
        if (_userRepository.user.bids.contains(bias.bid)){
          followingFlag.add(true);
        }else{
          followingFlag.add(false);
        }
      }
      searchBiasModel.setFollowedBiasList(followingFlag);
      UtilityState state = SearchBiasState(searchBiasModel);
      //_coreStateStack.add(state);
      emit(state);
    }else{
      var duration = const Duration(milliseconds: 150);
      sleep(duration);
      return;
    }
  }

  bool _executeFunction(){
    DateTime now = DateTime.now();
    if(_timing == null || now.difference(_timing!).inMilliseconds >= 300){
      _timing = now;
      return true;
    }else{
      return false;
    }
  }

  Future<void> _onFollowBiasEvent(FollowBiasEvent event, Emitter<UtilityState> emit) async {
    String bid = event.bid;
    String keyword = event.keyword;

    User user = await _utilityRepository.fetchFollowBias(_userRepository.user.uid, bid);
    _userRepository.user = user;
    add(SearchBiasEvent(keyword));
  }
}
