//user model

class UserModel{
  User __user = User();

  User get_user() => this.__user;

  UserModel();

  UserModel.fromJson(Data){
    this.__user.setName(Data['uid']);
    this.__user.setName(Data['name']);
  }

  setUid(String uid){
    this.__user.setUid(uid);
  }
  setName(String name){
    this.__user.setUid(name);
  }
}

class User{
  String __uid = "";
  String __name = "";

  setUid(String uid){
    this.__uid = uid;
  }
  setName(String name){
    this.__name= name;
  }
  String getUid() => this.__uid;
  String getName() => this.__name;


}