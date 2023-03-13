import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalDataService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<File> writeToFile(String myMap, String fileName) async {
    final file = await _localFile(fileName);

    // Write the file
    return file.writeAsString(myMap);
  }

  //String needs to be decoded to map from json String
  Future<String> readFromFile(String fileName) async {
    try {
      final file = await _localFile(fileName);

      final String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return ""
      return "";
    }
  }
}

LocalDataService localDataService = LocalDataService();
