

class ImageListCategoryModel{
  final String bid;
  final String bname;
  final int numImage;
  final List<dynamic> firstImageList;
  final List<dynamic> secondImageList;
  final List<dynamic> thirdImageList;

  ImageListCategoryModel({
    required this.bid,
    required this.bname,
    required this.numImage,
    required this.firstImageList,
    required this.secondImageList,
    required this.thirdImageList,
});

  // 생성자
  factory ImageListCategoryModel.fromJson(Map data){
    print(data['body']);
    var bodyData = data['body'];

    return ImageListCategoryModel(
      bid: bodyData['bid'],
      bname: bodyData['bname'],
      numImage: bodyData['num_image'],
      firstImageList: bodyData['first_list'],
      secondImageList: bodyData['second_list'],
      thirdImageList: bodyData['third_list']
    );
  }
}

