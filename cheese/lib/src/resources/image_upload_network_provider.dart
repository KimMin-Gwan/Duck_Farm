import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:cheese/src/resources/main_json_parser.dart';
import 'package:cheese/src/model/image_model.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';


class TryGetImageDataApiJsonParser extends MainJsonParser{
  final Map body = {
    'uid' : '',
    'bid' : '',
    'schedule' : '',
    'date' : '',
    'detail' : '',
    'link' : '',
    'location' : '',
    'num_images' : 0
  };
  Uri __url = Uri();

  TryGetImageDataApiJsonParser(String endpoint):super(){
    __url = Uri(
      scheme: 'http',
      host:super.host,
      port:super.port,
      path:endpoint,
    );
  }

  void makeBodyData(uid, bname, schedule, date, detail, link, location, numImages){
    body['uid'] = uid;
    body['bname'] = bname;
    body['sname'] = schedule;
    body['date'] = date;
    body['detail'] = detail;
    body['link'] = link;
    body['location'] = location;
    body['num_images'] = numImages;
  }

  String getData() => super.makeSendData(this.body);

  Uri getUri() => this.__url;
}

class ImageUploadNetworkProvider{
  final String uploadPostEndpoint = '/core_system/upload_post';
  Client client = Client();

  Future<ImageUploadModel> fetchTryGetImageData(
      String uid, String bid, String schedule, String date, String detail, String link,
      String location, int numImages) async {
    TryGetImageDataApiJsonParser tryGetImageDataApiJsonParser = TryGetImageDataApiJsonParser(uploadPostEndpoint);
    tryGetImageDataApiJsonParser.setHeader(uid, uploadPostEndpoint);
    tryGetImageDataApiJsonParser.makeBodyData(uid, bid, schedule, date, detail, link, location, numImages);

    final response = await client.post(
        tryGetImageDataApiJsonParser.getUri(),
        headers: {'Content-Type': 'application/json'},
        body: tryGetImageDataApiJsonParser.getData()
    );
    print('request status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return ImageUploadModel.fromJson(jsonDecode(jsonDecode(utf8.decode(response.bodyBytes))));
    } else {
      throw Exception('Failed to load post');
    }
  }

  String generateSignatureKey(String key, String dateStamp, String regionName, String serviceName) {
    var kDate = Hmac(sha256, utf8.encode('AWS4' + key)).convert(utf8.encode(dateStamp)).bytes;
    var kRegion = Hmac(sha256, kDate).convert(utf8.encode(regionName)).bytes;
    var kService = Hmac(sha256, kRegion).convert(utf8.encode(serviceName)).bytes;
    var kSigning = Hmac(sha256, kService).convert(utf8.encode('aws4_request')).bytes;
    return base64.encode(kSigning);
  }

  Future<Map<String, dynamic>> fetchTryImageUpload(Map args, fileNames) async {
    var imagePath = './test_images/1003.jpg';

    try {
      var method = 'PUT';
      var service = 's3';
      var host = 'kr.object.ncloudstorage.com';
      var region = 'kr-standard';
      var endpoint = 'https://$host/${args['bucket_name']}/${args['object_name']}';
      var contentType = 'application/octet-stream';

      // Date/Time formatting for headers
      var t = DateTime.now().toUtc();
      var amzDate = t.toIso8601String().replaceAll(RegExp(r'\.\d+Z$'), 'Z').replaceAll('-', '').replaceAll(':', '').substring(0, 15) + 'Z';
      var dateStamp = t.toIso8601String().split('T')[0].replaceAll('-', '');

      // Create a canonical request
      var canonicalUri = '/${args['bucket_name']}/${args['object_name']}';
      var canonicalQuerystring = '';
      var canonicalHeaders = 'host:$host\nx-amz-content-sha256:UNSIGNED-PAYLOAD\nx-amz-date:$amzDate\n';
      var signedHeaders = 'host;x-amz-content-sha256;x-amz-date';
      var payloadHash = 'UNSIGNED-PAYLOAD';
      var canonicalRequest = '$method\n$canonicalUri\n$canonicalQuerystring\n$canonicalHeaders\n$signedHeaders\n$payloadHash';

      // Create a string to sign
      var algorithm = 'AWS4-HMAC-SHA256';
      var credentialScope = '$dateStamp/$region/$service/aws4_request';
      var stringToSign = '$algorithm\n$amzDate\n$credentialScope\n${sha256.convert(utf8.encode(canonicalRequest)).toString()}';

      // Calculate the signature
      var signingKey = generateSignatureKey(args['secret_key']!, dateStamp, region, service);
      var signature = Hmac(sha256, base64.decode(signingKey)).convert(utf8.encode(stringToSign)).toString();

      // Create authorization header
      var authorizationHeader = '$algorithm Credential=${args['access_key']}/$credentialScope, SignedHeaders=$signedHeaders, Signature=$signature';
      var headers = {
        'x-amz-date': amzDate,
        'x-amz-content-sha256': payloadHash,
        'Authorization': authorizationHeader,
        'Content-Type': contentType
      };

      // Upload file using PUT method
      var response;
      var file;
      var checkUpload = true;

      for (var fileName in fileNames){
        if(!checkUpload){
          break;
        }
        file = File(fileName);
        response = await http.put(Uri.parse(endpoint), body: file.readAsBytesSync(), headers: headers);
        if(response.statusCode != 200){
          print(response.statusCode);
          checkUpload = false;
        }
      }

      if (checkUpload) {
        return {'done': true};
      } else {
        return {'done': false, 'error_message': response.body};
      }
    } catch (e) {
      print(e.toString());
      return {'done': false, 'error_message': e.toString()};
    }
  }
}


