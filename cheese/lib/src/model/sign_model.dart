class SearchEmailModel{
  final bool flag;

  SearchEmailModel({
    required this.flag,
  });

  factory SearchEmailModel.fromJson(Map data){

    return SearchEmailModel(
        flag: data['body']['flag'],
    );
  }
}
