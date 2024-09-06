class AppConstant{
  static String? userToken;
}

class ErrorMessage {
  //static final String SOMETHING_WRONG = LocaleKeys.something_went_wrong.tr();
  static const String somethingWrong = "Something went wrong";
  static const String connectionError = "Connection error, please check your internet.";
  // LocaleKeys.error_connecting_to_server.tr();
  static const String timeOutError = "Connection timeout";
  //LocaleKeys.connection_timeout.tr();
  static const String unexpectedError = "Oops, Something went wrong";
  //LocaleKeys.unexpected_error.tr();
  static const String serverError = "Server error";
//LocaleKeys.server_error.tr();

}

class HttpMethod {
  HttpMethod._();
  static const String get = "get";
  static const String post = "post";
  static const String patch = "patch";
  static const String put = "put";
  static const String delete = "delete";
}