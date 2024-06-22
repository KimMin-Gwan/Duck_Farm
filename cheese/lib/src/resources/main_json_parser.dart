
//http://223.130.157.23/
import 'dart:convert';

class MainJsonParser{
  String host = '223.130.157.23';
  int port = 80;
  Map<String, dynamic> header = {
    'request-type' : 'default',
    'client-version' : '0.1.0',
    'client-ip' : '127.0.0.1',
    'uid' : '',
    'endpoint' : '/',
  };

  //String getUrl() => this._url;

  void setHeader(String uid, String endpoint){
    this.header['uid'] = uid;
    this.header['endpoint'] = endpoint;
  }

  String makeSendData(Map<dynamic, dynamic> body){
    Map<String, dynamic> request_body = {
      'header' : this.header,
      'body' : body
    };
    return jsonEncode(request_body);
  }
}