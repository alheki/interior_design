class BaseResponseModel {
  late final int statusCode;
  late final String message;

  BaseResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json["StatusCode"] ?? -1;
    message = json["Message"] ?? "";
  }
}
