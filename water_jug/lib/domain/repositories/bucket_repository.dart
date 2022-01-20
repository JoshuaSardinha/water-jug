import '../../domain/entities/bucket.dart';

abstract class BucketRepository {
  // Creating datasource here since we do not have need of more complex database or API methods
  Map<int, Bucket> bucketMap = {};

  // Using Futures in the abstract class to make it more future proof
  // Not necessary in our case, but it's the standard for database and server queries
  Future<Bucket> createBucket({ int? id, required int capacity, String? name });
  Future<Bucket?> getBucket(int id);
  Future<Bucket?> updateBucket(int id, { required int newContent });
  Future<void> clearBucketsMap();
}