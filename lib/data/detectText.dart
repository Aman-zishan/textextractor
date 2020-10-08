import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> detectText(String imagePath) async {
  var res = await http.get(
      'https://baconipsum.com/api/?type=all-meat&sentences=1&start-with-lorem=1');
  return Future.delayed(
      Duration(
        seconds: 5,
      ),
      () => json.decode(res.body)[0]);
}
