class DuplicateBucketException implements Exception {
  final String message;

  DuplicateBucketException({ this.message = "Bucket with id already exists" });
}