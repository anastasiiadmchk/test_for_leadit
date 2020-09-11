import 'dart:io';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:app_for_leadit/globals.dart';
import 'package:app_for_leadit/data_receivers/file_path.dart';
import 'package:app_for_leadit/json_decoders/comment_info.dart';

class CommentsReceiver {
  String commentsFileName = 'commentsdata.json';

  Future<List<Comment>> get getComments async {
    Map<String, String> headers = {"Content-type": "application/json"};
    List<Comment> comments;

    String _filePath = await FilePath().filePath(commentsFileName);
    File commentsFile = File(_filePath);

    if (commentsFile.existsSync()) {
      //commentsFile.deleteSync();
      var fileData = commentsFile.readAsStringSync();
      comments = json
          .decode(fileData)
          .map<Comment>((comment) => Comment.fromJson(comment))
          .toList();
      print('Comments cache');
    } else {
      print('Loading comments from api');
      try {
        await http.get(commentsUrl, headers: headers).then((response) {
          Iterable list = json.decode(response.body);
          comments = list.map((comment) => Comment.fromJson(comment)).toList();
          
          //store comments json to file
          commentsFile.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
        });
      } catch (error) {
        print(error);
      }
    }
    return comments;
  }
}
