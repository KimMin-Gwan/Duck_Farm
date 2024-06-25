import 'package:equatable/equatable.dart';
import 'package:cheese/src/model/image_model.dart';
import 'package:flutter/material.dart';

abstract class ImageUploadEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class InitImageUploadEvent extends ImageUploadEvent{
  @override
  List<Object> get props => [];
}

class TryImageUploadEvent extends ImageUploadEvent{
  final ImageUploadModel imageUploadModel;
  final List<String> fileNames;

  TryImageUploadEvent(
      this.imageUploadModel,
      this.fileNames
      );

  @override
  List<Object> get props => [imageUploadModel, fileNames];
}

class GetUploadImageDataEvent extends ImageUploadEvent{
  final String bid;
  final String schedule;
  final String date;
  final String detail;
  final String link;
  final String location;
  final List imageFilenames;

  GetUploadImageDataEvent(
      this.bid,
      this.schedule,
      this.date,
      this.detail,
      this.link,
      this.location,
      this.imageFilenames,
      );

  @override
  List<Object> get props => [bid, schedule, date, detail, link, location, imageFilenames];
}