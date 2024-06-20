class AppConstant{
  static const int HOME_PAGE = 0;
  static const int NEWS_PAGE = 1;
  static const int COMPLAINT_PAGE = 2;
  static const int LAW_PAGE = 3;
  static const int MENUE = 4;

  static const int RESET_INDEX = 0;

  static String? USER_TOKEN;
}

class ErrorMessage {
  //static final String SOMETHING_WRONG = LocaleKeys.something_went_wrong.tr();
  static const String SOMETHING_WRONG = "Something went wrong";
  static const String CONNECTION_ERROR = "Connection error, please check your internet.";
  // LocaleKeys.error_connecting_to_server.tr();
  static const String TIMEOUT_ERROR = "Connection timeout";
  //LocaleKeys.connection_timeout.tr();
  static const String UNEXPECTED_ERROR = "Oops, Something went wrong";
  //LocaleKeys.unexpected_error.tr();
  static const String SERVER_ERROR = "Server error";
//LocaleKeys.server_error.tr();

}

class HttpMethod {
  HttpMethod._();
  static const String GET = "get";
  static const String POST = "post";
  static const String PATCH = "patch";
  static const String PUT = "put";
  static const String DELETE = "delete";
}