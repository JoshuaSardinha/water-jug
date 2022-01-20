import 'dart:collection';
import 'dart:math';

import '../../domain/domain_rules/clear_actions_and_buckets.dart';
import '../entities/bucket_action.dart';
import '../entities/bucket.dart';
import '../repositories/bucket_action_repository.dart';
import '../repositories/bucket_repository.dart';

class SolveChallenge {
  final BucketRepository bucketRepository;
  final BucketActionRepository actionRepository;

  SolveChallenge(this.bucketRepository, this.actionRepository);

  Future<List<BucketAction>?> call(
      {required int bucketOneCapacity, required int bucketTwoCapacity, required int amountWanted}) async {
    // Breadth-First Search Solution
    // We will simulate all the possible states of the buckets with a graph
    // Each node represents a state of the pair of buckets and each edge represents an action taken with a bucket
    // In this scenario, the first path which fills the criteria using the BFS is the most efficient (shortest) one

    // Clear all of the old data
    ClearActionsAndBuckets(bucketRepository, actionRepository);

    // Create a new pair of buckets
    Bucket bucketOne = await bucketRepository.createBucket(capacity: bucketOneCapacity, name: 'A');
    Bucket bucketTwo = await bucketRepository.createBucket(capacity: bucketTwoCapacity, name: 'B');

    // Create a 'visited matrix' using dynamic programming to make the algorithm more efficient
    List<List<bool>> visitedMatrix = getVisitedMatrix(capacityOne: bucketOne.capacity, capacityTwo: bucketTwo.capacity);
    // We will use a queue to set up the order for the BFS
    Queue<Pair> queue = Queue();

    // We will always leave from 0, 0
    Pair initialState = Pair(a: 0, b: 0, actions: []);
    queue.add(initialState);

    // Loops through all the possibilities, if no answer is found, no answer exists for the given inputs
    while (queue.isNotEmpty) {
      Pair current = queue.removeFirst();

      if (current.a > bucketOne.capacity || current.b > bucketTwo.capacity || visitedMatrix[current.a][current.b]) {
        continue;
      }
      visitedMatrix[current.a][current.b] = true;

      // Returns the first valid path
      if (current.a == amountWanted || current.b == amountWanted) {
        actionRepository.replaceActions(newActionList: current.actions);
        return current.actions;
      }

      // Enqueues the possible 'Filling bucket' actions
      // We do have a bit of boilerplate for the Bucket object cloning to save each action stage
      queue.add(Pair(a: bucketOne.capacity, b: current.b, actions: [
        ...current.actions!,
        BucketAction(
            code: BucketActionCode.fill,
            primaryBucket: Bucket(
                id: bucketOne.id, capacity: bucketOne.capacity, name: bucketOne.name, content: bucketOne.capacity),
            secondaryBucket:
                Bucket(id: bucketTwo.id, capacity: bucketTwo.capacity, name: bucketTwo.name, content: current.b))
      ]));
      queue.add(Pair(a: current.a, b: bucketTwo.capacity, actions: [
        ...current.actions!,
        BucketAction(
            code: BucketActionCode.fill,
            isTransferenceFromPrimary: false,
            primaryBucket:
                Bucket(id: bucketOne.id, capacity: bucketOne.capacity, name: bucketOne.name, content: current.a),
            secondaryBucket: Bucket(
                id: bucketTwo.id, capacity: bucketTwo.capacity, name: bucketTwo.name, content: bucketTwo.capacity))
      ]));

      // Enqueues the possible 'Emptying bucket' actions
      queue.add(Pair(a: 0, b: current.b, actions: [
        ...current.actions!,
        BucketAction(
            code: BucketActionCode.empty,
            primaryBucket: Bucket(id: bucketOne.id, capacity: bucketOne.capacity, name: bucketOne.name, content: 0),
            secondaryBucket:
                Bucket(id: bucketTwo.id, capacity: bucketTwo.capacity, name: bucketTwo.name, content: current.b))
      ]));
      queue.add(Pair(a: current.a, b: 0, actions: [
        ...current.actions!,
        BucketAction(
            code: BucketActionCode.empty,
            isTransferenceFromPrimary: false,
            primaryBucket:
                Bucket(id: bucketOne.id, capacity: bucketOne.capacity, name: bucketOne.name, content: current.a),
            secondaryBucket: Bucket(id: bucketTwo.id, capacity: bucketTwo.capacity, name: bucketTwo.name, content: 0))
      ]));

      // Enqueues the possible 'Transfer between buckets' actions
      int transferAmount = min(current.a, bucketTwoCapacity - current.b);
      queue.add(Pair(a: current.a - transferAmount, b: current.b + transferAmount, actions: [
        ...current.actions!,
        BucketAction(
            code: BucketActionCode.transfer,
            primaryBucket: Bucket(
                id: bucketOne.id,
                capacity: bucketOne.capacity,
                name: bucketOne.name,
                content: current.a - transferAmount),
            secondaryBucket: Bucket(
                id: bucketTwo.id,
                capacity: bucketTwo.capacity,
                name: bucketTwo.name,
                content: current.b + transferAmount))
      ]));

      transferAmount = min(current.b, bucketOneCapacity - current.a);
      queue.add(Pair(a: current.a + transferAmount, b: current.b - transferAmount, actions: [
        ...current.actions!,
        BucketAction(
            code: BucketActionCode.transfer,
            primaryBucket: Bucket(
                id: bucketOne.id,
                capacity: bucketOne.capacity,
                name: bucketOne.name,
                content: current.a + transferAmount),
            secondaryBucket: Bucket(
                id: bucketTwo.id,
                capacity: bucketTwo.capacity,
                name: bucketTwo.name,
                content: current.b - transferAmount),
            isTransferenceFromPrimary: false)
      ]));
    }

    actionRepository.replaceActions(newActionList: null);
    return null;
  }

  List<List<bool>> getVisitedMatrix({required int capacityOne, required int capacityTwo}) {
    List<List<bool>> matrix =
        List<List<bool>>.generate(capacityOne + 1, (index) => List<bool>.filled(capacityTwo + 1, false));
    return matrix;
  }
}

class Pair {
  final int a;
  final int b;
  final List<BucketAction>? actions;

  Pair({required this.a, required this.b, this.actions});
}
