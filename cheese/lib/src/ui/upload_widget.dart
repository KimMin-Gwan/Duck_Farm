import 'package:cheese/src/ui/styles/upload_theme.dart';
import 'package:flutter/material.dart';

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
                      onPressed: (){}),
              ),
              Container(
                width: width * 0.7,
                child: Text('사진 등록',style: _style.uploadTitleText,),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){},
                  child: Text("완료",style: _style.completeButton),
                )
              )
            ],
          ),
        ),
        FileSelecterWidget(),
        InfoOptionWidget(),
      ],
    );
  }
}

// 파일 업로드 부분 위젯
class FileSelecterWidget extends StatefulWidget {
  const FileSelecterWidget({super.key});

  @override
  State<FileSelecterWidget> createState() => _FileSelecterWidgetState();
}

class _FileSelecterWidgetState extends State<FileSelecterWidget> {
  var _style = UploadTheme();

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;
    return fileSelectArea(queryWidth, queryHeight);
  }

  Widget fileSelectArea(width, height){
    return Container(
      width: width,
      height: height * 0.29,
      color: _style.mainWhiteColor,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: width * 0.55,
              height: height * 0.25,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload_outlined, color: Colors.black.withOpacity(0.6),),
                    Text('0/10'),
                    Text('jpeg,png,gif')
                  ],
                )
              ),
              decoration: _style.imageBoxDecoration
              ),
            ),
        ],
      )
    );
  }
}

// 정보 입력 부분 위젯
class InfoOptionWidget extends StatefulWidget {
  const InfoOptionWidget({super.key});

  @override
  State<InfoOptionWidget> createState() => _InfoOptionWidgetState();
}

class _InfoOptionWidgetState extends State<InfoOptionWidget> {
  var _style = UploadTheme();

  TextEditingController biasTextController = TextEditingController();
  TextEditingController scheduleTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  TextEditingController detailTextController = TextEditingController();
  TextEditingController linkTextController = TextEditingController();
  TextEditingController locationTextController = TextEditingController();

  final int maxLength = 20;
  String currentText = '';
  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

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
                        TextSpan(text: "최애",style: _style.infoTitleText),
                        TextSpan(text: "*",style: _style.essentialStarText),
                      ]
                  )
              )
          ),
          Container(
              padding: EdgeInsets.only(left: 30),
              width: width * 0.8,
              height: height * 0.045,
            child: TextField(
              controller: biasTextController,
              decoration: InputDecoration(
                hintText: "최애를 입력해주세요.",
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
                          TextSpan(text: "일정",style: _style.infoTitleText),
                          TextSpan(text: "*",style: _style.essentialStarText),
                        ]
                    )
                )
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              width: width * 0.8,
                height: height * 0.045,
              child: TextField(
                controller: scheduleTextController,
                decoration: InputDecoration(
                    hintText: "일정을 입력해주세요.",
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
                    TextSpan(text: "날짜",style: _style.infoTitleText),
                    TextSpan(text: "*",style: _style.essentialStarText),
                  ]
                )
              )
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              width: width * 0.8,
              height: height * 0.045,
              child: TextField(
                  controller: dateTextController,
                  decoration: InputDecoration(
                      hintText: "날짜를 입력해주세요.",
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
              child: Text("내용",style: _style.infoTitleText,),
            ),
            Container(
              padding: const EdgeInsets.only(left: 30),
              width: width * 0.8,
              height: height * 0.045,
              child: TextField(
                controller: detailTextController,
                maxLength: maxLength,
                decoration: InputDecoration(
                    hintText: "내용을 작성해주세요.",
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
              child: Text("링크",style: _style.infoTitleText,),
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              width: width * 0.8,
              height: height * 0.045,
              child: TextField(
                  controller: linkTextController,
                  decoration: InputDecoration(
                      hintText: "링크를 추가해주세요.",
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
              child: Text("위치",style: _style.infoTitleText,),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    width: width * 0.8,
                    height: height * 0.045,
                    child: TextField(
                        controller: locationTextController,
                        decoration: InputDecoration(
                          hintText: "위치를 추가해주세요.",
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
