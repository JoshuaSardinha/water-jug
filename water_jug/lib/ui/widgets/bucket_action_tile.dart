import 'package:flutter/material.dart';

import '../../domain/entities/bucket.dart';

class BucketActionTile extends StatelessWidget {
  final Bucket bucketA;
  final Bucket bucketB;
  final String explanation;
  final bool successful;

  const BucketActionTile(
      {required this.bucketA, required this.bucketB, required this.explanation, this.successful = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text('Bucket ${bucketA.name}:'),
              flex: 3,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Flexible(
              child: Text(
                bucketA.content.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              flex: 1,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Flexible(
              child: Text('Bucket ${bucketB.name}:'),
              flex: 3,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Flexible(
              child: Text(bucketB.content.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
              flex: 1,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Flexible(
              child: Center(
                  child: Text(
                explanation,
                textAlign: TextAlign.center,
              )),
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
