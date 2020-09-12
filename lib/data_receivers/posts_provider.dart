import 'package:app_for_leadit/data_receivers/posts_list_receiver.dart';
import 'package:app_for_leadit/json_decoders/post_info.dart';
import 'package:flutter/material.dart';

class PostsProvider with ChangeNotifier{
  Duration _cacheValidDuration;
    DateTime lastFetchTime;
    List<Post> _posts;

    PostsProvider(){
      _cacheValidDuration = Duration(minutes: 30);
        lastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);
        _posts = [];
    }

    Future<void> refreshAllPosts() async{
      print('Load posts from API');
      _posts = await PostsList().postsList;
      lastFetchTime = DateTime.now();
      notifyListeners();
    }

    Future<List<Post>> getAllPosts({bool forceRefresh = false}) async {
      bool shouldRefreshFromApi = (null == _posts || _posts.isEmpty || null == lastFetchTime || lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidDuration)) || forceRefresh);
      if (shouldRefreshFromApi) {
        await refreshAllPosts();
      }
      print(shouldRefreshFromApi);
      return _posts;
    }

}