import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/data_domain/data_domain.dart';
class BiasListModel{
  final List<Bias> biasList;


  BiasListModel({
    required this.biasList,
  });

  factory BiasListModel.fromJson(Map data){
    print(data['body']);
    List<Bias> biasList = [];
    List<Bias> order = data['body']['bias_order'];
    for ( var  biasData in data['body']['bias_list'] ) {
      Bias bias = Bias();
      bias.bid = biasData['bid'];
      bias.bname = biasData['bname'];
      biasList.add(bias);
      biasList.add(data['body']['bias_order']);
    }
    return BiasListModel(biasList);
  }
}