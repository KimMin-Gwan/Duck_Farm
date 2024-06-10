

class MainJsonParser{
  String host = "127.0.0.1";
  int port = 22;
  Map<String, dynamic> header = {
    'request-type' : 'default',
    'client-version' : '0.1.0',
    'client-ip' : '127.0.0.1',
    'uid' : '',
    'endpoint' : "/",
  };

  //String getUrl() => this._url;

  void setHeader(String uid, String endpoint){
    this.header['uid'] = uid;
    this.header['endpoint'] = endpoint;
  }

  Map<String, dynamic> makeSendData(Map<dynamic, dynamic> body){
    Map<String, dynamic> request_body = {
      'header' : this.header,
      'body' : body
    };
    return request_body;
  }
}