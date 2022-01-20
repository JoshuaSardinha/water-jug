import '../../common/exceptions/duplicate_bucket_exception.dart';
import '../entities/bucket.dart';
import '../repositories/bucket_repository.dart';

class CreateBucket {
  final BucketRepository bucketRepository;

  CreateBucket(this.bucketRepository);

  Future<Bucket?> call({ int? bucketId, required int capacity, String? name }) async {
    try {
      Bucket? bucket = await bucketRepository.createBucket(id: bucketId, capacity: capacity, name: name);
      return bucket;
    } on DuplicateBucketException {
      print('Invalid bucket id');
    }
  }
}