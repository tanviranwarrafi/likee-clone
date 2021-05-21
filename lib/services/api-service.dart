import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:likee_clone/common/api-urls.dart';

class ApiService {
  httpGetMethod({String endPoint}) async {
    var client = http.Client();
    try {
      final response = await http.get(
        ApiUrl.baseUrl + endPoint,
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return null;
      }
    } finally {
      client.close();
    }
  }

  httpGetMethodWithToken({String endPoint, String bearerToken}) async {
    var client = http.Client();
    try {
      final response = await http.get(
        ApiUrl.baseUrl + endPoint,
        headers: <String, String>{'Content-Type': 'application/json', 'Authorization': bearerToken},
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return null;
      }
    } finally {
      client.close();
    }
  }

  httpPostMethod({String endPoint}) async {
    var client = http.Client();
    try {
      final response = await http.post(
        ApiUrl.baseUrl + endPoint,
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return null;
      }
    } finally {
      client.close();
    }
  }

  httpPostMethodWithToken({String endPoint, String bearerToken}) async {
    var client = http.Client();
    try {
      final response = await http.post(
        ApiUrl.baseUrl + endPoint,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': bearerToken,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return null;
      }
    } finally {
      client.close();
    }
  }

  httpPostMethodWithBody({String endPoint, var body}) async {
    var client = http.Client();
    try {
      final response = await http.post(
        ApiUrl.baseUrl + endPoint,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return null;
      }
    } finally {
      client.close();
    }
  }

  httpPostMethodWithBodyAndToken({String endPoint, String bearerToken, var body}) async {
    var client = http.Client();
    try {
      final response = await http.post(
        ApiUrl.baseUrl + endPoint,
        headers: <String, String>{'Content-Type': 'application/json', 'Authorization': bearerToken},
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        return null;
      }
    } finally {
      client.close();
    }
  }
}
