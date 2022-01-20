import '../../common/strings/bucket_action_strings.dart';
import '../../domain/entities/bucket.dart';

enum BucketActionCode { empty, fill, transfer }

class BucketAction {
  final BucketActionCode code;
  final Bucket primaryBucket;
  final Bucket secondaryBucket;
  // Is the primary being emptied/filled or is the water being transferred out of it
  final bool isTransferenceFromPrimary;

  BucketAction(
      {required this.code, required this.primaryBucket, required this.secondaryBucket, this.isTransferenceFromPrimary = true});

  String getExplanationByCode() {
    switch (code) {
      case BucketActionCode.empty:
        if (isTransferenceFromPrimary) {
          return emptyBucketString(primaryBucket.name ?? primaryBucket.id.toString());
        } else {
          return emptyBucketString(secondaryBucket.name ?? secondaryBucket.id.toString());
        }
      case BucketActionCode.fill:
        if (isTransferenceFromPrimary) {
          return fillBucketString(primaryBucket.name ?? primaryBucket.id.toString());
        } else {
          return fillBucketString(secondaryBucket.name ?? secondaryBucket.id.toString());
        }
      case BucketActionCode.transfer:
        if (isTransferenceFromPrimary) {
          return transferBucketString(primaryBucket.name ?? primaryBucket.id.toString(),
              secondaryBucket.name ?? secondaryBucket.id.toString());
        } else {
          return transferBucketString(secondaryBucket.name ?? secondaryBucket.id.toString(),
              primaryBucket.name ?? primaryBucket.id.toString());
        }
    }
  }
}
