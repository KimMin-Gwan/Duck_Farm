import 'package:flutter/material.dart';

class OriginalImage extends StatelessWidget {
  final String iid;
  const OriginalImage({super.key, required this.iid});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(20.0),
        minScale: 0.1,
        maxScale: 2.0,
        child: Container(
          child: Image.network("https://kr.object.ncloudstorage.com/cheese-images/${iid}.jpg")
        ),
      ),
    );
  }
}


