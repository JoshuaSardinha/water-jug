import '../../../common/exceptions/inexistent_bucket_exception.dart';
import '../entities/bucket.dart';
import '../repositories/bucket_repository.dart';

class FillBucket {
  final BucketRepository bucketRepository;

  FillBucket(this.bucketRepository);

  Future<Bucket?> call({ required int bucketId, required int content }) async {
    try {
      Bucket? bucket = await bucketRepository.getBucket(bucketId);
      if (bucket != null) {
        bucket.content = bucket.capacity;
        await bucketRepository.updateBucket(bucketId, newContent: bucket.capacity);
      }
      return bucket;
    } on InexistentBucketException {
      print('Invalid bucket id');
    }
  }
}