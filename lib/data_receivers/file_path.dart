import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FilePath{
  Future<Directory> documentsPath() async {
    String tempPath = (await getApplicationDocumentsDirectory())?.path;
    return Directory("$tempPath").create();
  }

  Future<String> filePath(String fileName) async {
    final path = (await documentsPath()).path;
    return "$path/$fileName";
  }
}