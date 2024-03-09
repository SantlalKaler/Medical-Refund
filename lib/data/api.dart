import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../presentation/base/view_utils.dart';
import 'app_exception.dart';

class API {
  final Dio _dio = Dio();
  final Connectivity _connectivity = Connectivity();
  final options = Options(
    sendTimeout:
    10000, // Timeout duration in milliseconds (e.g., 5000 for 5 seconds)
  );

  Future<bool> checkConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  API() {
    _dio.options.baseUrl = AppUrls.baseUrl;
    _dio.interceptors.add(PrettyDioLogger(
      responseBody: true
    ));
  }

  postRequest(url, data) async {
    printParams(url, data);
    try {
      bool isConnected = await checkConnectivity();
      if (isConnected) {
        Response response;
        try {
          response = await _dio.post(url, data: data, options: options);
        } on SocketException {
          showSnackbar("Alert", "No Internet connection");
          throw FetchDataException("No Internet connection");
        }
        return response.data;
      } else {
        showSnackbar("Alert",
            "No Internet connection or Your Internet connection is slow.");
      }
    } catch (e) {
      if (e is DioError) {
        if (e.error is TimeoutException) {
          showSnackbar("Alert",
              "No Internet connection or Your Internet connection is slow.");
        } else {
          showSnackbar("Alert",
              "No Internet connection or Your Internet connection is slow.");
        }
      }
    }
  }

  getRequest(url, data) async {
    printParams(url, data);
    try {
      bool isConnected = await checkConnectivity();
      if (isConnected) {
        Response response;
        try {
          response = await _dio.get(url, queryParameters: data);
        } on SocketException {
          showSnackbar("Alert",
              "No Internet connection.");
          throw FetchDataException("No Internet connection");
        }
        return response.data;
      } else {
        showSnackbar("Alert",
            "No Internet connection or Your Internet connection is slow.");
      }
    } catch (e) {
      if (e is DioError) {
        if (e.error is TimeoutException) {
          showSnackbar("Alert",
              "No Internet connection or Your Internet connection is slow.");
        } else {
          showSnackbar("Alert",
              "No Internet connection or Your Internet connection is slow.");
        }
      }
    }
  }

  getRequestWithoutData(url) async {
    printParams(url, {});
    try {
      bool isConnected = await checkConnectivity();
      if (isConnected) {
        Response response;
        try {
          response = await _dio.get(url);
        } on SocketException {
          showSnackbar("Alert",
              "No Internet connection or Your Internet connection is slow.");
          throw FetchDataException("No Internet connection");
        }
        return response.data;
      } else {
        showSnackbar("Alert",
            "No Internet connection or Your Internet connection is slow.");
      }
    } catch (e) {
      if (e is DioError) {
        if (e.error is TimeoutException) {
          showSnackbar("Alert",
              "No Internet connection or Your Internet connection is slow.");
        } else {
          showSnackbar("Alert",
              "No Internet connection or Your Internet connection is slow.");
        }
      }
    }
  }

  printParams(url, data) {
    print(" \n\n============================($url)======================\n\n"
        "DATA => $data\n\n"
        "=========================================================================================================================\n\n");
  }
}
