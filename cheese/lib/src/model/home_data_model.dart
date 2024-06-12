import 'package:cheese/src/model/bias_model.dart';

class HomeDataModel {
  final String uid = '1234-abcd-5678';
  final List<Bias> biases;
  final List homeBodyData;

  HomeDataModel({required this.biases, required this.homeBodyData});

  factory HomeDataModel.fromJson(Data){
    List<Bias> biases = [];
    List homeBodyData = [];
    print(Data.runtimeType);
    for(var response_bias in Data['body']['bias']){
      Bias bias = Bias();
      bias.set_bid(response_bias['bid']);
      bias.set_bname(response_bias['bname']);
      biases.add(bias);
    }
    homeBodyData = Data['body']['home_body_data'];

    return HomeDataModel(biases: biases, homeBodyData: homeBodyData);
  }
}


class DetailImageModel{
  final String iid;
  final String bias_name;
  final String user_name;
  final bool user_owner;
  final String upload_date;
  final String schedule_date;
  final String image_detail;
  final String schedule_name;
  final String location;

  DetailImageModel({required this.iid,
    required this.bias_name,
    required this.user_name,
    required this.user_owner,
    required this.upload_date,
    required this.schedule_date,
    required this.image_detail,
    required this.schedule_name,
    required this.location,

  });

  factory DetailImageModel.fromJson(Map data){
    print(data['body']);
    return DetailImageModel(
        iid: data['body']['iid'],
        bias_name: data['body']['bias_name'],
        user_name: data['body']['user_name'],
        user_owner: data['body']['user_owner'],
        upload_date: data['body']['upload_date'],
        image_detail: data['body']['image_detail'],
        schedule_date: data['body']['schedule']['date'],
        schedule_name: data['body']['schedule']['name'],
        location: data['body']['schedule']['location']
    );
  }
}


