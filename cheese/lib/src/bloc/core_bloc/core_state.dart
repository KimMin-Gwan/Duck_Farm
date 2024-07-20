import 'package:cheese/src/data_domain/data_domain.dart';
import 'package:cheese/src/model/image_model.dart';
import 'package:equatable/equatable.dart';
import 'package:cheese/src/model/home_data_model.dart';
import 'package:cheese/src/model/bias_model.dart';


abstract class CoreState extends Equatable{
  @override
  List<Object> get props => [];
}

class InitCoreState extends CoreState{
  @override
  List<Object> get props => [];
}

class NoneBiasState extends CoreState{
  final HomeDataModel homeDataModel;
  final String date;
  NoneBiasState(this.homeDataModel, this.date);

  @override
  List<Object> get props => [homeDataModel, date];
}

class BiasListState extends CoreState{
  final BiasListModel biasListModel;

  BiasListState(this.biasListModel);

  @override
  List<Object> get props => [biasListModel];
}

class DetailImageState extends CoreState{
  final DetailImageModel detailImageModel;

  DetailImageState(this.detailImageModel);

  @override
  List<Object> get props => [detailImageModel];
}

class ImageListCategoryState extends CoreState{
  final ImageListCategoryModel imageListCategoryModel;

  ImageListCategoryState(this.imageListCategoryModel);

  @override
  List<Object> get props => [imageListCategoryModel];
}

class ImageListCategoryByScheduleState extends CoreState{
  final ImageListCategoryModel imageListCategoryModel;

  ImageListCategoryByScheduleState(this.imageListCategoryModel);

  @override
  List<Object> get props => [imageListCategoryModel];
}
