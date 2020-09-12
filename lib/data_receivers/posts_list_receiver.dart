import 'dart:convert' show json;
import 'package:http/http.dart' show Client;
import 'package:app_for_leadit/globals.dart';
import 'package:app_for_leadit/json_decoders/post_info.dart';

class PostsList {
  Client client = Client();
  String fileName = 'postsdata.json';
  
  //Fetching posts data
  Future<List<Post>> get postsList async {
    Map<String, String> headers = {"Content-type": "application/json"};
    List<Post> postsList;
      try {
        await client.get(postsUrl, headers: headers).then((response) {
          Iterable list = json.decode(response.body);
          postsList = list.map<Post>((post) => Post.fromJson(post)).toList();
        });
      } catch (error) {
        print(error);
      }
    return postsList;
  }
}
