import 'package:blogviewer/data.dart';
import 'package:blogviewer/widgets/BlogCard.dart';
import 'package:flutter/material.dart';

import 'downloadScreen.dart';

var data;
var a;
var loaded = false;
var leng = 0;

class BlogList extends StatefulWidget {
  const BlogList({super.key});
  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  Future fetchdata() async {
    Map<String, dynamic> data = await fetchBlogs();
    a = data["blogs"] as List;
    leng = a.length;
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        cacheExtent: 9999,
        itemCount: leng,
        itemBuilder: (context, index) {
          return blogcard(
              title: a[index]["title"], image_url: a[index]["image_url"]);
        }); //data["blogs"][index]["title"] data["blogs"][index]["image_url"]

    if (loaded == false) {
      content = Center(child: CircularProgressIndicator());
    }

    // TODO: implement build
    return Scaffold(
      body: content,
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.download),
            title: Text("Downloads"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return downloadScreen();
                },
              ));
            },
          )
        ],
      )),
      appBar: AppBar(title: Text("Blogs")),
    );
  }
}
