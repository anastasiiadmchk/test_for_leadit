import 'package:app_for_leadit/data_receivers/user_receiver.dart';
import 'package:app_for_leadit/json_decoders/user_info.dart';
import 'package:flutter/material.dart';

class UsersProvider with ChangeNotifier{
  Duration _cacheValidDuration;
    DateTime _lastFetchTime;
    List<User> _users;
    
    UsersProvider(){
      _cacheValidDuration = Duration(minutes: 30);
        _lastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);
        _users = [];
    }

    Future<void> refreshAllUsers() async{

      print('Load users from API');
      _users = await UserReceiver().getUsers;
      _lastFetchTime = DateTime.now();
      notifyListeners();
    
    }

    Future<List<User>> getAllUsers({bool forceRefresh = false}) async {

      bool shouldRefreshFromApi = (null == _users || _users.isEmpty || null == _lastFetchTime || _lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidDuration)) || forceRefresh);
      if (shouldRefreshFromApi) {
        await refreshAllUsers();
      }
      print(shouldRefreshFromApi);
      return _users;
    

    }
}