import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:uplanit_supplier/core/enums/api_response_type.dart';
import 'package:uplanit_supplier/core/enums/request_type.dart';

abstract class Api {
  static const String baseUrl = 'https://uplanit-test-api.herokuapp.com';

  Future<http.Response> request({
    RequestType requestType,
    String path,
    dynamic parameter,
    String token,
  });


  Future<String> requestFile({
    RequestType requestType,
    String path,
    dynamic parameter,
    File file,
  });

  
}


class ApiResponse<T> {
  ApiResponseStatus status;
  T data;
  String message;

  ApiResponse.initialize(this.data);
  ApiResponse.loading(this.message) : status = ApiResponseStatus.LOADING;
  ApiResponse.completed(this.data) : status = ApiResponseStatus.COMPLETED;
  ApiResponse.error(this.message) : status = ApiResponseStatus.ERROR;

  @override
  String toString() {
    return "Status: $status \nMessage: $message \n Data : $data";
  }
}
