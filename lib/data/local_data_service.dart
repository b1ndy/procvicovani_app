import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalDataService {
  //returns most commonly used path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  //returns path+filename
  Future<File> localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  //writes file - Map needs to be encoded to json String
  Future<File> writeToFile(String myMap, String fileName) async {
    final file = await localFile(fileName);
    return file.writeAsString(myMap);
  }

  //reads file - String needs to be decoded to map from json String
  Future<String> readFromFile(String fileName) async {
    try {
      final file = await localFile(fileName);

      final String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return ""
      return "";
    }
  }
}

LocalDataService localDataService = LocalDataService();
