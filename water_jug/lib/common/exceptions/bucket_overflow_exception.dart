class BucketOverflowException implements Exception {
  final String message;

  BucketOverflowException({ this.message = "Bucket capacity does not support the content" });
}