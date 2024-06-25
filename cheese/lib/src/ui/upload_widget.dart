import 'package:cheese/src/ui/styles/upload_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/image_upload/image_upload_bloc.dart';
import 'package:cheese/src/bloc/image_upload/image_upload_state.dart';
import 'package:cheese/src/bloc/image_upload/image_upload_event.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

// 이미지 업로드 메인 위젯
class ImageUploadWidget extends StatefulWidget {
  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  var _style = UploadTheme(); // 테마
  final maxWidth = 400.0;
  final maxHeight = 900.0;
  bool interaction = false;

  TextEditingController biasTextController = TextEditingController();
  TextEditingController scheduleTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  TextEditingController detailTextController = TextEditingController();
  TextEditingController linkTextController = TextEditingController();
  TextEditingController locationTextController = TextEditingController();

  List fileNames = [];

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: queryWidth,
            height: queryHeight,
            color: _style.mainWhiteColor,
            child: uploadWidgetBody(queryWidth, queryHeight)
        ),
      )
    );
  }

  Widget uploadWidgetBody(width, height){
    return Column(
      children: [
        SizedBox(
          width: width,
          height: height * 0.03,
        ),
        Container(
          width: width,
          height: height * 0.08,
          color: _style.mainWhiteColor,
          child: Row(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: (){
                        BlocProvider.of<CoreBloc>(context).add(LoadBackwardEvent());
                        Navigator.pop(context);
                      }),
              ),
              Container(
                width: width * 0.7,
                child: Text('사진 등록',style: _style.uploadTitleText,),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                    BlocProvider.of<ImageUploadBloc>(context).add(GetUploadImageDataEvent(
                        biasTextController.text,
                        scheduleTextController.text,
                        dateTextController.text,
                        detailTextController.text,
                        linkTextController.text,
                        locationTextController.text,
                        fileNames,
                    ));
                  },
                  child: Text('완료',style: _style.completeButton),
                )
              )
            ],
          ),
        ),
        _fileSelecterWidget(width, height),
        _infoOptionWidget(width, height),
      ],
    );
  }

  Widget _fileSelecterWidget(width, height) {
    return fileSelectArea(width, height);
  }

  Widget fileSelectArea(width, height){
    return InkWell(
      onTap:() async{
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg'],
          allowMultiple: true,
          withData: false
        );
        print("hello");

        if( result != null && result.files.isNotEmpty ){
          for (var file in result.files){
            String fileName = file.name;
            String? filePath = file.path;
            fileNames.add(filePath);
          }

        }
      },
      child: Container(
        width: width,
        height: height * 0.29,
        color: _style.mainWhiteColor,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: width * 0.55,
                height: height * 0.25,
                decoration: _style.imageBoxDecoration,
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_upload_outlined, color: Colors.black.withOpacity(0.6),),
                        const Text('0/10'),
                        const Text('jpeg,png,gif')
                      ],
                    )
                ),
              ),
            ),
          ],
        )
      )
    );
  }


  final int maxLength = 20;
  String currentText = '';
  @override
  Widget _infoOptionWidget(queryWidth, queryHeight) {
    return Container(
      width: queryWidth,
      height: queryHeight * 0.6,
      color: _style.mainWhiteColor,
      child: Column(
        children: [
          biasInputArea(queryWidth, queryHeight),
          scheduleInputArea(queryWidth, queryHeight),
          dateInputArea(queryWidth, queryHeight),
          detailInputArea(queryWidth, queryHeight),
          linkInputArea(queryWidth, queryHeight),
          locationInputArea(queryWidth, queryHeight),
        ],
      ),
    );
  }

  Widget biasInputArea(width, height){
    return Container(
      width: width,
      height: height * 0.091,
      color: _style.mainWhiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.03,
            padding: EdgeInsets.only(left: 25),
              child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text: '최애',style: _style.infoTitleText),
                        TextSpan(text: '*',style: _style.essentialStarText),
                      ]
                  )
              )
          ),
          Container(
              padding: EdgeInsets.only(left: 30),
              width: width * 0.9,
              height: height * 0.045,
            child: TextField(
              controller: biasTextController,
              decoration: InputDecoration(
                hintText: '최애를 입력해주세요.',
                  hintStyle: _style.emptyDataText
              ),
            )
          ),
        ],
      )
    );
  }

  Widget scheduleInputArea(width, height){
    return Container(
      width: width,
      height: height * 0.091,
      color: _style.mainWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: height * 0.03,
              padding: EdgeInsets.only(left: 25),
                child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: '일정',style: _style.infoTitleText),
                          TextSpan(text: '*',style: _style.essentialStarText),
                        ]
                    )
                )
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              width: width * 0.9,
                height: height * 0.045,
              child: TextField(
                controller: scheduleTextController,
                decoration: InputDecoration(
                    hintText: '일정을 입력해주세요.',
                    hintStyle: _style.emptyDataText
                ),
              )
            )
          ],
        )
    );
  }

  Widget dateInputArea(width, height){
    return Container(
      width: width,
      height: height * 0.091,
      color: _style.mainWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: height * 0.03,
              padding: EdgeInsets.only(left: 25),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '날짜',style: _style.infoTitleText),
                    TextSpan(text: '*',style: _style.essentialStarText),
                  ]
                )
              )
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              width: width * 0.9,
              height: height * 0.045,
              child: TextField(
                  controller: dateTextController,
                  decoration: InputDecoration(
                      hintText: '날짜를 입력해주세요.',
                      hintStyle: _style.emptyDataText
                  )
              ),
            ),
          ],
        )
    );
  }

  Widget detailInputArea(width, height){
    return Container(
      width: width,
      height: height * 0.091,
      color: _style.mainWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.03,
              padding: EdgeInsets.only(left: 25),
              child: Text('내용',style: _style.infoTitleText,),
            ),
            Container(
              padding: const EdgeInsets.only(left: 30),
              width: width * 0.9,
              height: height * 0.045,
              child: TextField(
                controller: detailTextController,
                maxLength: maxLength,
                decoration: InputDecoration(
                    hintText: '내용을 작성해주세요.',
                    hintStyle: _style.emptyDataText,
                    counterText: '',
                    suffix: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                          '${currentText.length}/$maxLength'
                      ),
                    )
                ),
                onChanged: (value){
                  setState(() {
                    currentText = value;
                  });
                  },
             ),
           ),
          ],
        )
        );
  }

  Widget linkInputArea(width, height){
    return Container(
      width: width,
      height: height * 0.091,
      color: _style.mainWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.03,
              padding: EdgeInsets.only(left: 25),
              child: Text('링크',style: _style.infoTitleText,),
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              width: width * 0.9,
              height: height * 0.045,
              child: TextField(
                  controller: linkTextController,
                  decoration: InputDecoration(
                      hintText: '링크를 추가해주세요.',
                      hintStyle: _style.emptyDataText
                  )
              ),
            ),
          ],
        )
    );
  }

  Widget locationInputArea(width, height){
    return Container(
      width: width,
      height: height * 0.091,
      color: _style.mainWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.03,
              padding: EdgeInsets.only(left: 25),
              child: Text('위치',style: _style.infoTitleText,),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    width: width * 0.9,
                    height: height * 0.045,
                    child: TextField(
                        controller: locationTextController,
                        decoration: InputDecoration(
                          hintText: '위치를 추가해주세요.',
                          hintStyle: _style.emptyDataText,
                          suffixIcon: Icon(Icons.search, color: Colors.grey,),
                        )
                    ),
                  ),
                ],
              )
            ),
          ],
        )
    );
  }
}
