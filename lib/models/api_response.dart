class APIResponse<T> {
  final bool isOk;
  final String message;
  final T result;
  final int status;

  APIResponse({
    required this.isOk,
    required this.message,
    required this.result,
    required this.status,
  });

  @override
  String toString() =>
      'APIResponse{isOk: $isOk, status: $status, message: $message, result: $result}';
}
