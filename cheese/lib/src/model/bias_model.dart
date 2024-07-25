import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/data_domain/data_domain.dart';
class BiasListModel{
  final List<Bias> biasList;
  //final List<String> ordering;


  BiasListModel({
    required this.biasList,
    //required this.ordering
  });

  factory BiasListModel.fromJson(Map data){
    print(data);
    List<Bias> biasList = [];
    //List ordering = data['body']['bias_order'];

    for ( Map<String, dynamic>  biasData in data['body']['bias_list'] ) {
      print(biasData);
      Bias bias = Bias();
      bias.makeWithDict(biasData);
      biasList.add(bias);
    }
    return BiasListModel(biasList: biasList);
  }
}