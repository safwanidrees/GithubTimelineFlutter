import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:github_flutter/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'exception.dart';

class ApiProvider {
  Future<dynamic> post(String url, dynamic param) async {
    log("url --- : $url");
    log("data --- : $param");

    dynamic responseJson;
    try {
      final response = await http.post(Uri.tryParse(url)!,
          body: param, headers: {'Authorization': 'token ${Api.token}'});
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    log("url --- : $url ${Api.token}");

    dynamic responseJson;
    try {
      final response = await http.get(Uri.tryParse(url)!,
          headers: {'Authorization': 'token ${Api.token}'});

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic param) async {
    log("url --- : $url");
    log("data --- : $param");

    dynamic responseJson;
    try {
      Response response;
      if (param == null) {
        response = await http.put(Uri.tryParse(url)!,
            headers: {'Authorization': 'token ${Api.token}'});
      } else {
        response = await http.put(Uri.tryParse(url)!,
            body: param, headers: {'Authorization': 'token ${Api.token}'});
      }

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, dynamic param) async {
    log("url --- : $url");
    log("data --- : $param");

    dynamic responseJson;
    try {
      Response response;
      if (param == null) {
        response = await http.delete(Uri.tryParse(url)!,
            headers: {'Authorization': 'token ${Api.token}'});
      } else {
        response = await http.delete(Uri.tryParse(url)!,
            body: param, headers: {'Authorization': 'token ${Api.token}'});
      }

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> patch(String url, dynamic param) async {
    log("url --- : $url");
    log("data --- : $param");

    dynamic responseJson;
    try {
      Response response;
      if (param == null) {
        response = await http.patch(Uri.tryParse(url)!,
            headers: {'Authorization': 'token ${Api.token}'});
      } else {
        response = await http.patch(Uri.tryParse(url)!,
            body: param, headers: {'Authorization': 'token ${Api.token}'});
      }

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    var responseJson = json.decode(response.body.toString());
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 400:
        throw BadRequestException(responseJson["message"].toString());
      case 401:
      case 403:
        throw UnauthorisedException(responseJson["message"].toString());
      case 404:
        throw InvalidUrlException(responseJson["message"]);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}
