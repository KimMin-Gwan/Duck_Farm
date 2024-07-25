import 'package:cheese/src/model/bias_model.dart';
import 'package:cheese/src/data_domain/data_domain.dart';

class HomeDataModel {
  final String uid = '1234-abcd-5678';
  final List<Bias> biases;
  final Map calenderData;
  final List homeBodyData;

  HomeDataModel({required this.biases, required this.calenderData, required this.homeBodyData});

  factory HomeDataModel.fromJson(Data){
    List<Bias> biases = [];
    List homeBodyData = [];
    Map calenderData = {};
    print(Data['body']);
    for(var response_bias in Data['body']['bias']){
      Bias bias = Bias();
      bias.bid = response_bias['bid'];
      bias.bname = response_bias['bname'];
      biases.add(bias);
    }
    homeBodyData = Data['body']['home_body_data'];
    calenderData = Data['body']['calender'];

    Bias plus_bias = Bias();
    plus_bias.bid = ("0000");
    plus_bias.bname = ("");
    biases.add(plus_bias);

    return HomeDataModel(biases: biases, calenderData: calenderData, homeBodyData: homeBodyData);
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
  final bool like;

  DetailImageModel({required this.iid,
    required this.bias_name,
    required this.user_name,
    required this.user_owner,
    required this.upload_date,
    required this.schedule_date,
    required this.image_detail,
    required this.schedule_name,
    required this.location,
    required this.like,
  });

  factory DetailImageModel.fromJson(Map data){
    print(data['body']);
    return DetailImageModel(
        iid: data['body']['iid'],
        bias_name: data['body']['bname'],
        user_name: data['body']['uname'],
        user_owner: data['body']['user_owner'],
        upload_date: data['body']['upload_date'],
        image_detail: data['body']['image_detail'],
        schedule_date: data['body']['schedule']['date'],
        schedule_name: data['body']['schedule']['sname'],
        location: data['body']['schedule']['location'],
        like: data['body']['like_state']
    );
  }
}


