import 'dart:io';
import 'dart:convert' show json;
import 'package:http/http.dart' show Client;
import 'package:app_for_leadit/globals.dart';
import 'package:app_for_leadit/data_receivers/file_path.dart';
import 'package:app_for_leadit/json_decoders/post_info.dart';

class PostsList {
  Client client = Client();
  String fileName = 'postsdata.json';
  
  //Fetching posts data
  Future<List<Post>> get postsList async {
    Map<String, String> headers = {"Content-type": "application/json"};
    List<Post> postsList;

    String _filePath = await FilePath().filePath(fileName);
    File postsFile = File(_filePath);

    if (postsFile.existsSync()) {
      var fileData = postsFile.readAsStringSync();
      
      postsList = json
          .decode(fileData)
          .map<Post>((post) => Post.fromJson(post))
          .toList();

      print('Loading posts from cache');
      
    } else {
      print('Loading posts from API');

      try {
        await client.get(postsUrl, headers: headers).then((response) {
          Iterable list = json.decode(response.body);
          postsList = list.map<Post>((post) => Post.fromJson(post)).toList();
          postsFile.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
        });
      } catch (error) {
        print(error);
      }
    }
    return postsList;
  }
}
