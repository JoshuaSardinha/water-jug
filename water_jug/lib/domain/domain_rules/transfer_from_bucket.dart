import '../../../common/exceptions/inexistent_bucket_exception.dart';

import '../entities/bucket.dart';
import '../repositories/bucket_repository.dart';

class TransferFromBucket {
  final BucketRepository bucketRepository;

  TransferFromBucket(this.bucketRepository);

  Future<void> call({required int originBucketId, required int targetBucketId}) async {
    try {
      Bucket? originBucket = await bucketRepository.getBucket(originBucketId);
      Bucket? targetBucket = await bucketRepository.getBucket(targetBucketId);

      if (originBucket != null && targetBucket != null) {
        int transferAmount = 0;

        if (originBucket.content > (targetBucket.capacity - targetBucket.content)) {
          transferAmount = targetBucket.capacity - targetBucket.content;
        } else {
          transferAmount = originBucket.content;
        }

        originBucket.content -= transferAmount;
        targetBucket.content += transferAmount;

        await bucketRepository.updateBucket(originBucket.id, newContent: originBucket.content);
        await bucketRepository.updateBucket(targetBucket.id, newContent: targetBucket.content);
      }
    } on InexistentBucketException {
      print('Invalid bucket id');
    }
  }
}
