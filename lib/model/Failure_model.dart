// Dart imports:
import 'dart:convert';

FailureModel failureModelFromJson(String str) =>
    FailureModel.fromJson(json.decode(str));

String failureModelToJson(FailureModel data) => json.encode(data.toJson());

class FailureModel {
  FailureModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;

  String? message;
  String? data;

  factory FailureModel.fromJson(Map<String, dynamic> json) => FailureModel(
        status: json['status'] ?? false,
        message: json['message'] ?? '',
        data: json['data'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };

  static FailureModel networkError() {
    return FailureModel(
      message: 'No internet connection',
      status: false,
    );
  }

  static FailureModel commonFailureModel({String? message}) {
    return FailureModel(
      message: message ?? 'Something went wrong! try later.',
      status: false,
    );
  }
}
