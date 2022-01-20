import '../../common/exceptions/bucket_overflow_exception.dart';
import '../../common/exceptions/duplicate_bucket_exception.dart';
import '../../domain/entities/bucket.dart';
import '../../domain/repositories/bucket_repository.dart';

import '../../common/exceptions/inexistent_bucket_exception.dart';

class BucketRepositoryImpl implements BucketRepository {
  @override
  Map<int, Bucket> bucketMap = {};

  @override
  Future<Bucket> createBucket({ int? id, required int capacity, String? name}) async {
    if (id == null) {
      int highestId = -1;
      for (int key in bucketMap.keys) {
        if (highestId < key) {
          highestId = key;
        }
      }
      int newBucketId = highestId + 1;

      Bucket newBucket = Bucket(id: newBucketId, capacity: capacity, name: name);
      bucketMap[newBucketId] = newBucket;
      return newBucket;
    } else {
      if (bucketMap[id] != null) {
        return Future.error(DuplicateBucketException());
      }
      Bucket newBucket = Bucket(id: id, capacity: capacity, name: name);
      bucketMap[id] = newBucket;
      return newBucket;
    }
  }

  @override
  Future<Bucket?> getBucket(int id) async {
    return bucketMap[id];
  }

  @override
  Future<Bucket> updateBucket(int id, {required int newContent}) async {
    Bucket? bucket = await getBucket(id);
    if (bucket == null) {
      return Future.error(InexistentBucketException());
    } else if (newContent > bucket.capacity) {
      return Future.error(BucketOverflowException());
    } else {
      bucket.content += newContent;
      return bucket;
    }
  }

  @override
  Future<void> clearBucketsMap() async {
    bucketMap = {};
  }
}