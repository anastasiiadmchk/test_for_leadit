import 'package:app_for_leadit/data_receivers/comments_receiver.dart';
import 'package:app_for_leadit/json_decoders/comment_info.dart';
import 'package:flutter/material.dart';

class CommentsProvider with ChangeNotifier{

  Duration _cacheValidDuration;
    DateTime _lastFetchTime;
    List<Comment> _comments;
    
    CommentsProvider(){
      _cacheValidDuration = Duration(minutes: 30);
        _lastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);
        _comments = [];
    }

    Future<void> refreshAllComments() async{

      print('Load comments from API');
      _comments = await CommentsReceiver().getComments;
      print('comments received');
      _lastFetchTime = DateTime.now();
      notifyListeners();
    
    }

    Future<List<Comment>> getAllComments({bool forceRefresh = false}) async {

      bool shouldRefreshFromApi = (null == _comments || _comments.isEmpty || null == _lastFetchTime || _lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidDuration)) || forceRefresh);
      if (shouldRefreshFromApi) {
        await refreshAllComments();
      }
      print(shouldRefreshFromApi);
      return _comments;
    

    }

}