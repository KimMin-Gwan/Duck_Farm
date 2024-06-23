

class ImageListCategoryModel{
  final String bid;
  final String bname;
  final int numImage;
  final List<dynamic> firstImageList;
  final List<dynamic> secondImageList;
  final List<dynamic> thirdImageList;
  final String scheduleDate;
  final String scheduleName;

  ImageListCategoryModel({
    required this.bid,
    required this.bname,
    required this.numImage,
    required this.firstImageList,
    required this.secondImageList,
    required this.thirdImageList,
    required this.scheduleDate,
    required this.scheduleName
});

  // 생성자
  factory ImageListCategoryModel.fromJson(Map data){
    print(data['body']);
    var bodyData = data['body'];
    if (data['header']['state-code'] == "209"){
      return ImageListCategoryModel(
        bid: bodyData['bid'],
        bname: bodyData['bname'],
        numImage: bodyData['num_image'],
        firstImageList: bodyData['first_list'],
        secondImageList: bodyData['second_list'],
        thirdImageList: bodyData['third_list'],
        scheduleDate: "",
        scheduleName: "",
      );
    } else if (data['header']['state-code'] == "210"){
      return ImageListCategoryModel(
        bid: bodyData['bid'],
        bname: bodyData['bname'],
        numImage: bodyData['num_image'],
        firstImageList: bodyData['first_list'],
        secondImageList: bodyData['second_list'],
        thirdImageList: bodyData['third_list'],
        scheduleDate: bodyData['schedule_date'],
        scheduleName: bodyData['schedule_name'],
      );
    }else{
      return ImageListCategoryModel(
        bid: "",
        bname: "",
        numImage: 0,
        firstImageList: [],
        secondImageList: [],
        thirdImageList: [],
        scheduleDate: "",
        scheduleName: "",
      );
    }
  }
}

