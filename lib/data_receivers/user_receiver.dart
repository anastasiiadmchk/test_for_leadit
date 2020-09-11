import 'dart:io';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:app_for_leadit/globals.dart';
import 'package:app_for_leadit/data_receivers/file_path.dart';
import 'package:app_for_leadit/json_decoders/user_info.dart';


class UserReceiver {
  String usersFileName = 'usersdata.json';

  Future<List<User>> get getUsers async {
    Map<String, String> headers = {"Content-type": "application/json"};
    List<User> usersList;

    String _filePath = await FilePath().filePath(usersFileName);
    File usersFile = File(_filePath);

    if (usersFile.existsSync()) {
      String fileData = usersFile.readAsStringSync();

      usersList = json
          .decode(fileData)
          .map<User>((user) => User.fromJson(user))
          .toList();
          
      print('Cache user');
    } else {
      print('Load user from api');
      try {
        await http.get(usersUrl, headers: headers).then((response) {
          Iterable list = json.decode(response.body);
          usersList = list.map((user) => User.fromJson(user)).toList();
          usersFile.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
        });
      } catch (error) {
        print(error);
      }
    }
    return usersList;
  }
}
