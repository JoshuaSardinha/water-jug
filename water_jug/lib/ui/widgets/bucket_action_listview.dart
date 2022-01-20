import 'package:flutter/material.dart';

import '../../domain/entities/bucket_action.dart';
import 'bucket_action_tile.dart';

class BucketActionListView extends StatelessWidget {
  final List<BucketAction> actionsList;

  const BucketActionListView({required this.actionsList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: actionsList.length,
        itemBuilder: (context, index) {
          BucketAction action = actionsList[index];
          return BucketActionTile(
              bucketA: action.primaryBucket,
              bucketB: action.secondaryBucket,
              explanation: action.getExplanationByCode());
        });
  }
}
