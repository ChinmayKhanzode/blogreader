import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:blogviewer/downloadmanager.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class blogdetail extends StatelessWidget {
  blogdetail(
      {super.key,
      required this.title,
      this.image_url,
      required this.down,
      this.filepath});
  final title, image_url;
  final filepath;
  bool down;

  Future<File> saveimage(Uri imgUrl) async {
    print("Saving image");
    var response = await http.get(imgUrl);
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file = new File(join(documentDirectory.path, '${title}.png'));
    file.writeAsBytesSync(response.bodyBytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(image_url),
              Text(
                title,
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 150,
                child: ElevatedButton(
                    onPressed: () async {
                      File imgfile = await saveimage(Uri.parse(image_url));
                      insertBlog(title, imgfile);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Download"), Icon(Icons.download)],
                    )),
              )
            ]);

    if(filepath!=null){
      content=Column(
         mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.file(File(filepath))
          ,Text(
                title,
                style: TextStyle(fontSize: 25),
              ),
      ],);
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
        child: content
      )
    );
  }
}
