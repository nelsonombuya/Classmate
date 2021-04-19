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

  final Map<String, String> _errorList = {
    // TODO Add more error messages
    'user-not-found': "The user doesn't exist.",
    'wrong-password': "Password is incorrect.",
  };
}
