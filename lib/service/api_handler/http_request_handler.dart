import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  static const String baseUrl = 'https://your-api-base-url.com/api/v1';
  static const Duration timeoutDuration = Duration(seconds: 30);

  // Headers for API calls
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Platform': Platform.isAndroid ? 'android' : 'ios',
  };

  // Headers with auth token
  static Map<String, String> _headersWithAuth(String? token) => {
    ..._headers,
    if (token != null) 'Authorization': 'Bearer $token',
  };

  // Generic GET request
  static Future<Map<String, dynamic>> get(
      String endpoint, {
        String? token,
        Map<String, String>? queryParams,
      }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final uriWithQuery = queryParams != null
          ? uri.replace(queryParameters: queryParams)
          : uri;

      final response = await http
          .get(uriWithQuery, headers: _headersWithAuth(token))
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, {
        Map<String, dynamic>? body,
        String? token,
      }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .post(
        uri,
        headers: _headersWithAuth(token),
        body: body != null ? json.encode(body) : null,
      )
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // POST request with file upload
  static Future<Map<String, dynamic>> postWithFile(
      String endpoint, {
        required Map<String, dynamic> fields,
        File? file,
        String? fileFieldName,
        String? token,
      }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll(_headersWithAuth(token));

      // Add fields
      fields.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Add file if provided
      if (file != null && fileFieldName != null) {
        request.files.add(
          await http.MultipartFile.fromPath(fileFieldName, file.path),
        );
      }

      final streamedResponse = await request.send().timeout(timeoutDuration);
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic PUT request
  static Future<Map<String, dynamic>> put(
      String endpoint, {
        Map<String, dynamic>? body,
        String? token,
      }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .put(
        uri,
        headers: _headersWithAuth(token),
        body: body != null ? json.encode(body) : null,
      )
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic DELETE request
  static Future<Map<String, dynamic>> delete(
      String endpoint, {
        String? token,
      }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .delete(uri, headers: _headersWithAuth(token))
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Handle HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (kDebugMode) {
      print('API Response: ${response.statusCode} - ${response.body}');
    }

    final Map<String, dynamic> responseData;

    try {
      responseData = json.decode(response.body);
    } catch (e) {
      throw ApiException(
        message: 'Invalid response format',
        statusCode: response.statusCode,
      );
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseData;
    } else {
      throw ApiException(
        message: responseData['message'] ?? 'Something went wrong',
        statusCode: response.statusCode,
        data: responseData,
      );
    }
  }

  // Handle errors
  static ApiException _handleError(dynamic error) {
    if (error is ApiException) {
      return error;
    }

    if (error is SocketException) {
      return const ApiException(
        message: 'No internet connection',
        statusCode: 0,
      );
    }

    if (error is http.ClientException) {
      return const ApiException(
        message: 'Network error occurred',
        statusCode: 0,
      );
    }

    if (error.toString().contains('TimeoutException')) {
      return const ApiException(
        message: 'Request timeout',
        statusCode: 408,
      );
    }

    return ApiException(
      message: error.toString(),
      statusCode: 0,
    );
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int statusCode;
  final Map<String, dynamic>? data;

  const ApiException({
    required this.message,
    required this.statusCode,
    this.data,
  });

  @override
  String toString() {
    return 'ApiException: $message (Status: $statusCode)';
  }
}

// API endpoints constants
class ApiEndpoints {
  // Auth endpoints
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String verifyOTP = '/auth/verify-otp';
  static const String resendOTP = '/auth/resend-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // User endpoints
  static const String profile = '/user/bar_more';
  static const String updateProfile = '/user/update-bar_more';
  static const String changePassword = '/user/change-password';
  static const String addressBook = '/user/address-book';
  static const String addAddress = '/user/address-book/add';
  static const String updateAddress = '/user/address-book/update';
  static const String deleteAddress = '/user/address-book/delete';
}