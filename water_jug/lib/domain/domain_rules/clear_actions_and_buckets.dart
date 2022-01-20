import '../../domain/repositories/bucket_action_repository.dart';
import '../repositories/bucket_repository.dart';

class ClearActionsAndBuckets {
  final BucketRepository bucketRepository;
  final BucketActionRepository actionRepository;

  ClearActionsAndBuckets(this.bucketRepository, this.actionRepository);

  Future<void> call() async {
    bucketRepository.clearBucketsMap();
    actionRepository.clearActionsList();
  }
}