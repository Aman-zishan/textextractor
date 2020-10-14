import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> saveText(String text) async {
  final directory = await getExternalStorageDirectory();
  String docName = '${DateTime.now()}.txt';
  File file = File('${directory.path}/' + docName);
  await file.writeAsString(text);
  print('saved at ${directory.path}/' + docName);
  return docName;
}
