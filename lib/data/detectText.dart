import 'package:dio/dio.dart';

Future<String> detectText(String imagePath) async {
  // get filename
  String fileName = imagePath.split('/').last;
  // set formdata to post file
  FormData formData = FormData.fromMap({
    "file": await MultipartFile.fromFile(imagePath, filename: fileName),
  });
  // send post request
  Dio dio = new Dio();
  var response = await dio.post(
    "http://textextractor2.herokuapp.com/api/v1/",
    data: formData,
  );
  // retrun results
  return response.data['message'];
}
