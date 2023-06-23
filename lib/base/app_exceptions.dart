class AppFirebaseException implements Exception {
  final String message;

  AppFirebaseException(this.message);

  @override
  String toString() {
    return message;
  }
}
