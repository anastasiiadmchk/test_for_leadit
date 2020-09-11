import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart' as testDart;
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert' show json;
import 'package:app_for_leadit/data_receivers/posts_list_receiver.dart';
import 'package:app_for_leadit/json_decoders/post_info.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testDart.test('Posts list receiver returns list of posts', () async {
    final postsListReceiver = PostsList();
    //Mocking http get response
    postsListReceiver.client = MockClient((request) async {
      final jsonMap = [
        {
          "userId": 1,
          "id": 1,
          "title":
              "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
          "body":
              "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
        }
      ];

      return Response(json.encode(jsonMap), 200);
    });

    //Solves troubles with path_provider package
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/path_provider');
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return ".";
    });

    final postsList = await postsListReceiver.postsList;
    Post post = postsList.first;
    expect(post.id, 1);
  });
}
