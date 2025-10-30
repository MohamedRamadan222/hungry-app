import 'package:dio/dio.dart';

import 'api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    if (error.response != null &&
        error.response?.data is Map<String, dynamic>) {
      final data = error.response?.data;
      if (data['message'] != null) {
        return ApiError(message: data['message']);
      }
    }
    if (statusCode == 302) {
      throw ApiError(message: 'this email already taken');
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: "Connection timeout. Please check your internet connection.",
        );
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Request timeout. Please try again.");
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Response timeout. Please try again.");
      default:
        return ApiError(
          message: "An unexpected error occurred. Please try again.",
        );
    }
  }
}
