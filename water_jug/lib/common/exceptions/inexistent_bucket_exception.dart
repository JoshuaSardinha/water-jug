class InexistentBucketException implements Exception {
  final String message;

  InexistentBucketException({ this.message = "Bucket with such id does not exist" });
}