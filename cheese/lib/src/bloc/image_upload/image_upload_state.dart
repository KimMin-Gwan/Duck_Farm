import 'package:cheese/src/model/image_model.dart';
import 'package:equatable/equatable.dart';

abstract class ImageUploadState extends Equatable{
  @override
  List<Object> get props => [];
}

class InitImageUploadState extends ImageUploadState{
  @override
  List<Object> get props => [];
}

class UploadErrorState extends ImageUploadState{
  @override
  List<Object> get props => [];
}

class UploadCompleteState extends ImageUploadState{
  @override
  List<Object> get props => [];
}
