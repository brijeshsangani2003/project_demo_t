import 'package:dartz/dartz.dart';
import 'package:project_demo_t/core/extension/extension.dart';
import 'package:project_demo_t/model/anime_model.dart';
import 'package:project_demo_t/model/success_model.dart';
import '../core/constants/network_constants.dart';
import '../model/Failure_model.dart';
//import 'package:either_dart/either.dart';

import 'Api_services.dart';

class ApiServices {
  Future<Either<FailureModel, SuccessModel>> signIn({
    required Map<String, dynamic> params,
  }) async {
    try {
      final result = await NetworkCall<SuccessModel>().handleApi(
        endpoint: NetworkConst.signIn,
        callType: ApiCallType.post,
        params: params,
        handleSuccess: (response) async {
          final fetchData =
              SuccessModel.fromJson((response as Map<String, dynamic>));
          return right(fetchData);
        },
        handle406: (response) async {
          final fetchData =
              FailureModel.fromJson((response as Map<String, dynamic>));

          return left(fetchData);
        },
      );

      return result;
    } catch (ex) {
      'api post report error: ${ex.toString()}'.printLog();
      return left(FailureModel.commonFailureModel());
    }
  }

  Future<Either<FailureModel, SuccessModel>> otpSent({
    required Map<String, dynamic> params,
  }) async {
    try {
      final result = await NetworkCall<SuccessModel>().handleApi(
        endpoint: NetworkConst.forgotPassword,
        callType: ApiCallType.post,
        params: params,
        handleSuccess: (response) async {
          final fetchData =
              SuccessModel.fromJson((response as Map<String, dynamic>));
          return right(fetchData);
        },
        handle406: (response) async {
          final fetchData =
              FailureModel.fromJson((response as Map<String, dynamic>));

          return left(fetchData);
        },
      );

      return result;
    } catch (ex) {
      'api post report error: ${ex.toString()}'.printLog();
      return left(FailureModel.commonFailureModel());
    }
  }

  Future<Either<FailureModel, SuccessModel>> verifyOtp({
    required Map<String, dynamic> params,
  }) async {
    try {
      final result = await NetworkCall<SuccessModel>().handleApi(
        endpoint: NetworkConst.verifyOtp,
        callType: ApiCallType.post,
        params: params,
        handleSuccess: (response) async {
          final fetchData =
              SuccessModel.fromJson((response as Map<String, dynamic>));
          return right(fetchData);
        },
        handle406: (response) async {
          final fetchData =
              FailureModel.fromJson((response as Map<String, dynamic>));

          return left(fetchData);
        },
      );

      return result;
    } catch (ex) {
      'api post report error: ${ex.toString()}'.printLog();
      return left(FailureModel.commonFailureModel());
    }
  }

  Future<Either<FailureModel, SuccessModel>> resetPassword({
    required Map<String, dynamic> params,
  }) async {
    try {
      final result = await NetworkCall<SuccessModel>().handleApi(
        endpoint: NetworkConst.resetPassword,
        callType: ApiCallType.post,
        params: params,
        handleSuccess: (response) async {
          final fetchData =
              SuccessModel.fromJson((response as Map<String, dynamic>));
          return right(fetchData);
        },
        handle406: (response) async {
          final fetchData =
              FailureModel.fromJson((response as Map<String, dynamic>));

          return left(fetchData);
        },
      );

      return result;
    } catch (ex) {
      'api post report error: ${ex.toString()}'.printLog();
      return left(FailureModel.commonFailureModel());
    }
  }

  Future<Either<FailureModel, AnimeModel>> anime() async {
    try {
      final result = await NetworkCall<AnimeModel>().handleApi(
        endpoint: NetworkConst.anime,
        callType: ApiCallType.get,
        handleSuccess: (response) async {
          final fetchData =
              AnimeModel.fromJson((response as Map<String, dynamic>));
          print('===+==${fetchData}');
          return right(fetchData);
        },
        handle406: (response) async {
          final fetchData =
              FailureModel.fromJson((response as Map<String, dynamic>));

          return left(fetchData);
        },
      );

      return result;
    } catch (ex) {
      'api post report error: ${ex.toString()}'.printLog();
      return left(FailureModel.commonFailureModel());
    }
  }
}
