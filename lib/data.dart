import 'package:blogviewer/screens/bloglist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future fetchBlogs() async {
  const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  const String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    if (response.statusCode == 200) {
      // Request successful, handle the response data here
      print('Response data: working');
    } else {
      // Request failed
      print('Request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
    var rawJson = response.body;
    var data = jsonDecode(rawJson);
    return data;
  } catch (e) {
    // Handle any errors that occurred during the request
    print('Error: $e');
  }
}

