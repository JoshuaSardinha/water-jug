import '../../domain/entities/bucket_action.dart';
import '../../domain/repositories/bucket_action_repository.dart';

class BucketActionRepositoryImpl implements BucketActionRepository {
  @override
  List<BucketAction>? actionList = [];

  @override
  Future<void> replaceActions({ required List<BucketAction>? newActionList }) async {
    actionList = newActionList;
  }

  @override
  Future<void> clearActionsList() async {
    actionList = [];
  }
}