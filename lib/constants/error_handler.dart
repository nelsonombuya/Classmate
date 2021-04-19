/// # Error Handler
/// Class used for context-sensitive error messages
class ErrorHandler {
  ErrorHandler(this.error) {
    this.message = _errorList.containsKey(error.code)
        ? _errorList[error.code]
        : error.message;
  }
  final error;
  String message;

  // * Use this to specify messages for particular error codes
  // The key for the error code, the value for the error message
  final Map<String, String> _errorList = {
    'user-not-found': "The user does not exist."
  };
}
