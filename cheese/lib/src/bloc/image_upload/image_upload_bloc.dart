import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/image_upload/image_upload_event.dart';
import 'package:cheese/src/bloc/image_upload/image_upload_state.dart';
import 'package:cheese/src/resources/image_repository.dart';
import 'package:cheese/src/model/image_model.dart';


class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState>{
  final ImageRepository _imageRepository = ImageRepository();
  

  ImageUploadBloc() : super(InitImageUploadState()){
    on<GetUploadImageDataEvent>(_onGetUploadImageDataEvent);
    on<TryImageUploadEvent>(_onTryImageUploadEvent);
  }

  Future<void> _onGetUploadImageDataEvent(GetUploadImageDataEvent event, Emitter<ImageUploadState> emit) async {
    int numImages = event.imageFilenames.length;
    
    ImageUploadModel imageUploadModel = await _imageRepository.fetchTryGetImageData(
        event.bid, event.schedule, event.date, event.detail, event.link, event.location, numImages);

    print(event.imageFilenames);
    print(imageUploadModel.iids);

    //add(TryImageUploadEvent(imageUploadModel, event.imageFilenames));
  }
  Future<void> _onTryImageUploadEvent(TryImageUploadEvent event, Emitter<ImageUploadState> emit) async{
    Map args = {
      'access_key': event.imageUploadModel.access_key,
      'secret_key': event.imageUploadModel.secret_token,
      'bucket_name': event.imageUploadModel.bucket_name,
      'object_name': event.imageUploadModel.iids
    };

    var result = _imageRepository.fetchTryImageUpload(args, event.fileNames);

  }
}
