import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class ApiCall {
  Future<Map<String, dynamic>> get(String url) async {
    Map<String, dynamic> datanotFound = {'data': 'Not Found'};
    Map<String, dynamic> responseBody;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      return datanotFound;
    }
  }

  Future<Map<String, dynamic>> getNewsbykeyword(String keyword) async {
    Map<String, dynamic> datanotFound = {'data': 'Not Found'};
    Map<String, dynamic> responseBody;
    var response = await http.get(Uri.parse(Constantss.search(keyword)));
    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);

      return responseBody;
    } else {
      return datanotFound;
    }
  }
}
