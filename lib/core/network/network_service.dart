import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_theming_app/core/error/failure.dart';
import 'package:movie_theming_app/core/network/authorization_interceptor.dart';

import '/core/constants/strings.dart';
import '../../generated/l10n.dart';

class NetworkService {
  final Dio dio;

  NetworkService(this.dio) {
    dio.options
      ..baseUrl = AppStrings.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..receiveDataWhenStatusError = true
      ..connectTimeout = const Duration(seconds: 60)
      ..receiveTimeout = const Duration(seconds: 60);

    addHeaders();
    addInterceptors();
  }

  void addInterceptors() {
    dio.interceptors.add(AuthorizationInterceptor());
  }

  void addHeaders() {
    dio.options.headers = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZDU0MmMyMGI4M2Y1ZDNhNDc2NTYzZGU2MjE1ZTE0NiIsIm5iZiI6MTY5Nzc0MzM5MS43MjYsInN1YiI6IjY1MzE4MjFmYjI2ODFmMDBhYzQ4MDM0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7aW5e23q4eVuKueX-WMLyzxvkxpbWfTPPgWVtEFhWZU",
      "Content-Type": "application/json",
      "accept": "application/json",
    };
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  String extractMessage(dynamic data) {
    if (data is Map) {
      return data['message'] ??
          data['msg'] ??
          data['error'] ??
          data['errorMessage'] ??
          data['status_message'] ??
          S().somethingWentWrong;
    }
    return S().somethingWentWrong;
  }

  Future<Either<Failure, dynamic>> _safeRequest(
    Future<Response> Function() requestFn,
  ) async {
    if (!await _hasInternetConnection()) {
      return Left(Failure(S().noInternet));
    }
    try {
      final response = await requestFn();

      dynamic responseData = response.data;
      if (responseData is String && responseData.isNotEmpty) {
        try {
          responseData = jsonDecode(responseData);
        } catch (e) {}
      }

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        if (responseData is Map && responseData['status'] == false) {
          final message = extractMessage(responseData);
          return Left(Failure(message, data: responseData['data']));
        }
        return Right(responseData);
      } else {
        final message = extractMessage(responseData);
        return Left(Failure(message, data: responseData));
      }
    } on DioException catch (e) {
      dynamic errorData = e.response?.data;
      if (errorData is String && errorData.isNotEmpty) {
        try {
          errorData = jsonDecode(errorData);
        } catch (_) {}
      }

      final message = extractMessage(errorData);
      return Left(Failure(message, data: errorData));
    } catch (e) {
      return Left(Failure(S().somethingWentWrong));
    }
  }

  Future<Either<Failure, dynamic>> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeRequest(
      () => dio.get(endPoint, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> postData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isRaw = true,
  }) async {
    final payload = data == null
        ? null
        : isRaw
        ? data
        : FormData.fromMap(data);
    return _safeRequest(
      () => dio.post(endPoint, data: payload, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> putData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeRequest(
      () => dio.put(endPoint, data: data, queryParameters: queryParameters),
    );
  }

  Future<Either<String, dynamic>> patchData({
    required String endPoint,
    required FormData data,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!await _hasInternetConnection()) {
      return Left(S().noInternet);
    }
    try {
      final response = await dio.patch(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on DioException catch (e) {
      final message = extractMessage(e.response?.data);
      return Left(message);
    } catch (_) {
      return Left(S().somethingWentWrong);
    }
  }

  Future<Either<String, dynamic>> deleteData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!await _hasInternetConnection()) {
      return Left(S().noInternet);
    }
    try {
      final response = await dio.delete(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on DioException catch (e) {
      final message = extractMessage(e.response?.data);
      return Left(message);
    } catch (_) {
      return Left(S().somethingWentWrong);
    }
  }

  Future<Either<Failure, dynamic>> uploadFile({
    required String endPoint,
    required FormData formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeRequest(
      () =>
          dio.post(endPoint, data: formData, queryParameters: queryParameters),
    );
  }

  Future<Either<String, dynamic>> downloadFile({
    required String fileUrl,
    required String savePath,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!await _hasInternetConnection()) {
      return Left(S().noInternet);
    }
    try {
      final response = await dio.download(
        fileUrl,
        savePath,
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      final message = extractMessage(e.response?.data);
      return Left(message);
    } catch (_) {
      return Left(S().somethingWentWrong);
    }
  }

  Left<Failure, dynamic> handleDioExceoptions(DioException e) {
    final message = extractMessage(e.response?.data);
    return Left(Failure(message));
  }
}
