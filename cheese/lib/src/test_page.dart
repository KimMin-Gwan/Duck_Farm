import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';


class UploadTest{
  Future<void> fetchTryImageUpload(fileNames) async{

    // 서버 URL
    Uri url = Uri.parse('http://223.130.157.23/upload_test');

    // 파일을 바이너리로 읽기
    File imageFile = File(fileNames[0]);
    List<int> imageBytes = await imageFile.readAsBytes();

    // HTTP POST 요청 보내기
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'image/jpg', // 이미지 포맷에 맞게 변경
      },
      body: imageBytes,
    );

    // 응답 확인
    if (response.statusCode == 200) {
      print('이미지 전송 성공!');
    } else {
      print('이미지 전송 실패 : ${response.statusCode}');
    }
  }
}