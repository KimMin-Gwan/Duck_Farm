import 'dart:convert';

class DictMakingError implements Exception {
  final String errorType;

  DictMakingError(this.errorType);
}

// 추상 클래스
abstract class SampleDomain {
  Map<String, dynamic> getDictFormData();
  void makeWithDict(Map<String, dynamic> dictData);
}

class User extends SampleDomain {
  String uid;
  String uname;
  String password;
  String birthday;
  String email;
  String nickname;
  List<dynamic> bids;

  User({
    this.uid = "",
    this.uname = "",
    this.password = "",
    this.birthday = "",
    this.email = "",
    this.nickname = "",
    this.bids = const [],
  });

  @override
  void makeWithDict(Map<String, dynamic> dictData) {
    try {
      uid = dictData['uid'];
      uname = dictData['uname'];
      password = dictData['password'];
      birthday = dictData['birthday'];
      email = dictData['email'];
      nickname = dictData['nickname'];
      bids = dictData['bids'];
    } catch (e) {
      throw DictMakingError(e.toString());
    }
  }

  @override
  Map<String, dynamic> getDictFormData() {
    return {
      "uid": uid,
      "uname": uname,
      "password": password,
      "birthday": birthday,
      "email": email,
      "nickname": nickname,
      "bids": bids,
    };
  }
}

class Bias extends SampleDomain {
  String bid;
  String bname;
  List<dynamic> sids;
  List<dynamic> iids;

  Bias({
    this.bid = "",
    this.bname = "",
    this.sids = const [],
    this.iids = const [],
  });

  @override
  void makeWithDict(Map<String, dynamic> dictData) {
    try {
      bid = dictData['bid'];
      bname = dictData['bname'];
      sids = dictData['sids'];
      iids = dictData['iids'];
    } catch (e) {
      throw DictMakingError(e.toString());
    }
  }

  @override
  Map<String, dynamic> getDictFormData() {
    return {
      "bid": bid,
      "bname": bname,
      "sids": sids,
      "iids": iids,
    };
  }
}

class Schedule {
  String sid;
  String sname;
  String date;
  String location;
  String type;
  List<dynamic> bids;
  List<dynamic> iids;

  Schedule({
    this.sid = "",
    this.sname = "",
    this.date = "",
    this.location = "",
    this.type = "",
    this.bids = const [],
    this.iids = const [],
  });

  void makeWithDict(Map<String, dynamic> dictData) {
    try {
      sid = dictData['sid'];
      sname = dictData['sname'];
      date = dictData['date'];
      location = dictData['location'];
      type = dictData['type'];
      bids = dictData['bids'];
      iids = dictData['iids'];
    } catch (e) {
      throw DictMakingError(e.toString());
    }
  }

  Map<String, dynamic> getDictFormData() {
    return {
      "sid": sid,
      "sname": sname,
      "date": date,
      "location": location,
      "type": type,
      "bids": bids,
      "iids": iids,
    };
  }
}

class Image {
  String iid;
  String iname;
  String imageType;
  String location;
  String imageDetail;
  String uploadDate;
  String sid;
  String bid;
  String uid;
  int like;

  Image({
    this.iid = "",
    this.iname = "",
    this.imageType = ".jpg",
    this.location = "",
    this.imageDetail = "",
    this.uploadDate = "",
    this.sid = "",
    this.bid = "",
    this.uid = "",
    this.like = 0,
  });

  void makeWithDict(Map<String, dynamic> dictData) {
    try {
      iid = dictData['iid'];
      iname = dictData['iname'];
      imageType = dictData['image_type'];
      imageDetail = dictData['image_detail'];
      uploadDate = dictData['upload_date'];
      location = dictData['location'];
      sid = dictData['sid'];
      bid = dictData['bid'];
      uid = dictData['uid'];
      like = dictData['like'];
    } catch (e) {
      throw DictMakingError(e.toString());
    }
  }

  Map<String, dynamic> getDictFormData() {
    return {
      "iid": iid,
      "iname": iname,
      "image_type": imageType,
      "image_detail": imageDetail,
      "upload_date": uploadDate,
      "location": location,
      "sid": sid,
      "bid": bid,
      "uid": uid,
      "like" : like
    };
  }
}
