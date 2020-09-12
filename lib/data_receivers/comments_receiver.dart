import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:app_for_leadit/globals.dart';
import 'package:app_for_leadit/json_decoders/comment_info.dart';

class CommentsReceiver {
  String commentsFileName = 'commentsdata.json';

  Future<List<Comment>> get getComments async {
    Map<String, String> headers = {"Content-type": "application/json"};
    List<Comment> comments;
      try {
        await http.get(commentsUrl, headers: headers).then((response) {
          Iterable list = json.decode(response.body);
          comments = list.map((comment) => Comment.fromJson(comment)).toList();
        });
      } catch (error) {
        print(error);
      }
    return comments;
  }
}
