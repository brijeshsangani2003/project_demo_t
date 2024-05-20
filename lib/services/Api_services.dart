// Dart imports:
import 'dart:io';

// Package imports:
///dartz package ma j either valu avi jase.
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
//import 'package:either_dart/either.dart';

// Project imports:
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_demo_t/core/extension/extension.dart';
import '../core/utils/preference.dart';
import '../model/Failure_model.dart';

enum ApiCallType {
  get,
  post,
  put,
  delete,
}

class NetworkCall<T> {
  Future<Either<FailureModel, T>> handleApi({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic> params = const {},
    Map<String, dynamic>? queryParameters,
    ApiCallType callType = ApiCallType.get,
    required Future<Either<FailureModel, T>> Function(Map responseBody)
        handleSuccess,
    Future<Either<FailureModel, T>> Function(Map responseBody)? handle400,
    Future<Either<FailureModel, T>> Function(Map responseBody)? handle406,
    Future<Either<FailureModel, T>> Function(Map responseBody)? handle401,
    Future<Either<FailureModel, T>> Function(Map responseBody)? handle409,
    Map<String, dynamic> multipartDataDict = const {},
    Map<String, List<String>> multipartDataArray = const {},
    bool isRecursiveCall = true,
    String responseLogTitle = 'response',
    bool isRequiredToken = false,
    final bool isFormData = false,
  }) async {
    //  final NetworkWatcher networkWatcher = get_pkg.Get.find<NetworkWatcher>();
    //  final NetworkWatcher networkWatcher = get_pkg.Get.put(NetworkWatcher());
    final isConnected = await InternetConnectionChecker().hasConnection;

    // final isConnected = networkWatcher.connectionType == 0 ? false : true;
    if (isConnected) {
      headers ??= isRequiredToken
          ? {
              'Authorization': 'Bearer ${preferences.token}',
              'Content-Type': 'application/x-www-form-urlencoded',
            }
          : {
              'Content-Type': 'application/x-www-form-urlencoded',
            };

      try {
        final dio = Dio();
        dio.options = BaseOptions(
          followRedirects: false,
          validateStatus: (status) {
            return (status ?? 0) <= 500;
          },
          connectTimeout: const Duration(milliseconds: 6000), // 1 minute
          headers: headers,
        );

        late Response<dynamic> response;
        final url = endpoint;

        FormData urlParams = FormData.fromMap(params);

        /// Upload multiple files array with single key
        await multipartDataArray.forEachAsync((key, files) async {
          urlParams = await addMultipartDataArray(
            formData: urlParams,
            multipartDataArray: files,
            keyName: key,
          );
        });

        /// Upload multiple files array with multiple keys dict
        urlParams = await addMultipartData(
          formData: urlParams,
          multipartDataDict: multipartDataDict,
        );

        switch (callType) {
          case ApiCallType.get:
            response = await dio.get(
              url,
              queryParameters: params,
            );
            break;
          case ApiCallType.post:
            response = await dio.post(
              url,
              data: isFormData ? urlParams : params,
              queryParameters: queryParameters,
            );
            break;
          case ApiCallType.put:
            response = await dio.put(url, data: params);
            break;
          case ApiCallType.delete:
            response = await dio.delete(url, data: params);
            break;
        }
        'token: ${preferences.token}'.printLog();
        'call type: $callType'.printLog();
        'URL: $url'.printLog();
        'Params: $params'.printLog();
        'Query Params: $queryParameters'.printLog();
        'response: ${response.data}'.printLog();
        'status code: ${response.statusCode}'.printLog();

        if (response.statusCode == 200) {
          final result = await handleSuccess(response.data);
          return result;
        } else if (response.statusCode == 401) {
          return left(FailureModel(message: 'unAuthorized user!'));
        } else if (response.statusCode == 400) {
          if (handle400 != null) {
            return handle400(response.data);
          } else {
            return left(FailureModel.fromJson(response.data));
          }
        } else if (response.statusCode == 409) {
          final result = await handleSuccess(response.data);
          return result;
        } else if (response.statusCode == 406) {
          if (handle406 != null) {
            return handle406(response.data);
          } else {
            return left(FailureModel.fromJson(response.data));
          }
        } else {
          return left(FailureModel.fromJson(response.data));
        }
      } on SocketException catch (_) {
        'API Service socket Error:'.printLog();
        return left(FailureModel.networkError());
      } catch (ex) {
        'API Service Error: $ex'.printLog();
        return left(FailureModel.commonFailureModel());
      }
    } else {
      'Network Error'.printLog();
      return left(FailureModel.networkError());
    }
  }

  static Future<FormData> addMultipartData({
    required FormData formData,
    required Map<String, dynamic> multipartDataDict,
  }) async {
    FormData urlParams = formData;
    // IF Files need to upload with dict
    await multipartDataDict.forEachAsync((key, value) async {
      String fileName = value.toString().fileName();
      'Upload FileName: $fileName'.printLog();
      final multipartData =
          await MultipartFile.fromFile(value, filename: fileName);
      urlParams.files.addAll(
        [MapEntry(key, multipartData)],
      );
    });
    return urlParams;
  }

  static Future<FormData> addMultipartDataArray({
    required FormData formData,
    required List<String> multipartDataArray,
    required String keyName,
  }) async {
    FormData urlParams = formData;

    for (var file in multipartDataArray) {
      formData.files.addAll([
        MapEntry(keyName, await MultipartFile.fromFile(file)),
      ]);
    }

    return urlParams;
  }
}
