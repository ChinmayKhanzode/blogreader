import 'dart:io';

import 'package:blogviewer/screens/blogDetail.dart';
import 'package:flutter/material.dart';

class blogcard extends StatelessWidget {
  blogcard(
      {super.key, required this.title, required this.image_url, this.filepath});
  final title;
  final image_url;
  final filepath;
  bool loading = false;
  var down = false;

  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    Widget content = Image.network(
      image_url,
      errorBuilder: (context, error, stackTrace) {
        return Center(
            child: Icon(
          Icons.do_disturb_alt,
          color: Colors.red,
        ));
      },
      fit: BoxFit.fitWidth,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    );
    if (filepath != null) {
      content = Image.file(File(filepath));
      down = true;
    }
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: content),
            Text(
              title,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => blogdetail(
                title: title,
                image_url: image_url,
                filepath:filepath,
                down: down,
              ),
            ));
      },
    );
  }
}
