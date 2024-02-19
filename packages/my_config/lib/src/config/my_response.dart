import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

class MyResponse {
  Response getFailureResponse({int? statusCode, String? message}) {
    final bodyJson = {
      'status_code': statusCode ?? HttpStatus.conflict,
      'message': message ?? 'This method is not allowed',
    };

    return Response.json(statusCode: HttpStatus.conflict, body: bodyJson);
  }

  Response getSuccessResponse({
    int? statusCode,
    String? message,
    String? keyData,
    dynamic data,
  }) {
    final bodyJson = <String, dynamic>{
      'status_code': statusCode ?? HttpStatus.ok,
      'message': message ?? 'ok',
    };

    if (keyData != null) {
      final dataJson = {keyData: data};
      bodyJson.addEntries(dataJson.entries);
    }

    return Response.json(body: bodyJson);
  }
}
