import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:uplanit_supplier/core/enums/request_type.dart';

import 'api.dart';

class ApiRepository extends Api {
  var client = http.Client();
  // var dio = locator<Dio>();

  @override
  Future<http.Response> request({
    RequestType requestType,
    String path,
    dynamic parameter,
    String token,
  }) {
    switch (requestType) {
      case RequestType.GET:
        return client.get(
          Api.baseUrl + path,
          headers: {
            "Authorization": "bearer $token",
          },
        );
      case RequestType.POST:
        return client.post(
          Api.baseUrl + path,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "bearer $token",
          },
          body: parameter,
        );
      case RequestType.PUT:
        return client.put(
          Api.baseUrl + path,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "bearer $token",
          },
          body: parameter,
        );
      case RequestType.DELETE:
        return client.delete(
          Api.baseUrl + path,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "bearer $token",
          },
        );
      default:
        return null;
    }
  }

  @override
  Future<String> requestFile({
    RequestType requestType,
    String path,
    parameter,
    File file,
  }) async {
    switch (requestType) {
      case RequestType.UPLOAD_IMAGE:
        List<int> imageBytes = file.readAsBytesSync();
        var uri = Uri.parse(path.substring(1, path.length - 1));
        var request = http.Request('PUT', uri);
        request.bodyBytes = imageBytes;
        var response = await client.send(request);
        print('s3 status code: ${response.statusCode}');
        if (response.statusCode == 200) return response.reasonPhrase;
        return null;
      default:
        return null;
    }
  }
}

/*FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(filePath),
        });
        String myKindaFormatURL = path.substring(1, path.length - 1);
        print('kinda URL: $myKindaFormatURL');
        var response = await dio.post<String>(
          myKindaFormatURL,
          data: formData,
        );
        print('s3 upload status: ${response.statusCode}');
        print('s3 upload reason: ${response.statusMessage}');
        print('s3 upload body: ${response.data}');
        return response.data;*/
