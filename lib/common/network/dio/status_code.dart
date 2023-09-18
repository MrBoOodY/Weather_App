///Manage the status of error codes
class StatusCode {
  //Code of successful data
  static const int requestDataOk = 0;

  //The request is successful
  static const int success = 200;

  //The request is for create.
  static const int created = 201;

  //The client must authenticate itself to get the requested response.
  static const int unauthenticated = 401;

  //The server access FORBIDDEN
  static const int forbidden = 403;

  //The request is  not found
  static const int notFound = 404;

  //The "POST" request contain data not matched with server side.
  static const int validationResponse = 422;

  //The request was sent more than 60 times in a minute.
  static const int tooManyAttempts = 429;

  //The server has encountered a situation it does not know how to handle.
  static const int internalServerError = 500;

  //The server, while working as a gateway to get a response needed to handle the request, got an invalid response
  static const int badGateway = 502;

  //The server, while working as a gateway to get a response needed to handle the request, got an invalid response
  static const int serviceUnavailable = 503;

  //This error response is given when the server is acting as a gateway and cannot get a response in time.
  static const int gatewayTimeout = 504;

  //Other errors
  static const int unknownError = 1000;

  //network error
  static const int networkError = 1001;

  //Server connection error
  static const int socketError = 1002;

  //internal Server error
  static const int serverError = 1003;

  //TIMEOUT_ERROR
  static const int timeoutError = 1004;

  //CANCEL_ERROR
  static const int cancelError = 1005;

  //PARSE_ERROR
  static const int parseError = 1006;
}
