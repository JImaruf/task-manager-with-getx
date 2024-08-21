import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import '../../app.dart';
import '../../controllers/auth_shared_preferences_controller.dart';
import '../../core/app_route.dart';
import '../model/network_response.dart';


class NetworkCaller {
  static Future<NetworkResponse> getResponse(String url) async {
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {
          'token': AuthSharedPreferencesController.accessToken,
        },
      );

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        redirectToLogin();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postResponse(String url, {Map<String, dynamic>? body}) async {
    try {
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-type': 'Application/json',
          'token': AuthSharedPreferencesController.accessToken,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        redirectToLogin();
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<void> redirectToLogin() async {
    await AuthSharedPreferencesController.clearAllData();
    Navigator.pushNamedAndRemoveUntil(TaskManager.navigatorKey.currentContext!,
        AppRoute.loginScreen, (Route<dynamic> route) => false);
  }
}
