class Outcome<T> {
  Outcome({
    this.isFailure = false,
    this.errorMessages,
  });

  bool isFailure;
  String? statusCode;
  dynamic errorMessages;
  T? body;
}
