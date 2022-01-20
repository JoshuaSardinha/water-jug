import '../entities/bucket_action.dart';

abstract class BucketActionRepository {
  List<BucketAction>? actionList = [];

  Future<void> replaceActions({ required List<BucketAction>? newActionList });
  Future<void> clearActionsList();
}