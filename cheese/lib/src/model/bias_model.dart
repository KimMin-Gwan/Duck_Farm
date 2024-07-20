import 'package:cheese/src/bloc/core_bloc/core_state.dart';

class BiasListModel{
  final String bid;
  final String bname;


  BiasListModel({
    required this.bid,
    required this.bname,
  });

  factory BiasListModel.fromJson(Map data){
    print(data['body']);
    return BiasListModel(
        bid: data['body']['bias_list']['bid'],
        bname: data['body']['bias_list']['bname'],
    );
  }
}