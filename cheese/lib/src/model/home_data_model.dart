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
  final bool user_owner;
  final String upload_date;
  final String schedule_date;
  final String schedule_name;
  final String location;

  DetailImageModel({required this.iid,
    required this.bias_name,
    required this.user_owner,
    required this.upload_date,
    required this.schedule_date,
    required this.schedule_name,
    required this.location,

  });

  factory DetailImageModel.fromJson(Map data){
    return DetailImageModel(iid: data['iid'],
        bias_name: data['bias_name'],
        user_owner: data['user_owner'],
        upload_date: data['upload_data'],
        schedule_date: data['schedule']['date'],
        schedule_name: data['schedule']['name'],
        location: data['schedule']['location']
    );
  }
}


