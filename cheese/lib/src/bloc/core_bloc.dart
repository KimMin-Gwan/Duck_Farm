import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_event.dart';
import 'package:cheese/src/bloc/core_state.dart';


class CoreBloc extends Bloc<CoreEvent, CoreState>{
  CoreBloc() : super(InitCoreState()){}
}



