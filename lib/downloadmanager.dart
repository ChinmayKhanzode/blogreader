import 'dart:io';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart';

List totaldata = [];

Future<Database> _getDatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbpath, "blogs.db"),
      onCreate: (db, version) {
    return db
        .execute("CREATE TABLE downloadedblogs(title TEXT,image_path TEXT)");
  }, version: 1);
  return db;
}

loadBlogs() async {
  final db = await _getDatabase();
  var response = await db.query('downloadedblogs');
  totaldata = response;
}

Future<void> insertBlog(String title, File image) async {
  // for image
  final appdir = await syspaths.getApplicationDocumentsDirectory();
  final filename = path.basename(image.path);

  final db = await _getDatabase();
  db.insert('downloadedblogs',
      {'title': title, 'image_path': '${appdir.path}/${filename}'});
  print("Done");
}
