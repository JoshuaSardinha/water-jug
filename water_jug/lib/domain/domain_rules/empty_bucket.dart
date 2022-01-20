import '../../common/exceptions/inexistent_bucket_exception.dart';
import '../entities/bucket.dart';
import '../repositories/bucket_repository.dart';

class EmptyBucket {
  final BucketRepository bucketRepository;

  EmptyBucket(this.bucketRepository);

  Future<Bucket?> call({required int bucketId}) async {
    try {
      Bucket? bucket = await bucketRepository.getBucket(bucketId);
      if (bucket != null) {
        bucket.content = 0;
        await bucketRepository.updateBucket(bucketId, newContent: 0);
      }
      return bucket;
    } on InexistentBucketException {
      print('Invalid bucket id');
    }
  }
}
