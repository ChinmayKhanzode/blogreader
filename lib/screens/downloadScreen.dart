import 'package:blogviewer/downloadmanager.dart';
import 'package:blogviewer/screens/bloglist.dart';
import 'package:blogviewer/widgets/BlogCard.dart';
import 'package:flutter/material.dart';

class downloadScreen extends StatefulWidget {
  downloadScreen({super.key});

  @override
  State<downloadScreen> createState() => _downloadScreenState();
}

class _downloadScreenState extends State<downloadScreen> {
  var loaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loader();
  }

  loader() async {
    await loadBlogs();
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    // TODO: implement build
    if (loaded == false) {
      content = CircularProgressIndicator();
    }
    content = Center(child: Text("Not Downloads"));
    if (totaldata != null) {
      print(totaldata);
      content = ListView.builder(
        itemCount: totaldata.length,
        itemBuilder: (context, index) {
          return blogcard(title: totaldata[index]['title'], image_url: "d",filepath: totaldata[index]['image_path'],);
        },
      );

    }
    return Scaffold(
      appBar: AppBar(),
      body:
          content,
    );
  }
}
