import 'package:flutter/material.dart';
import '../../../ui/widgets/bucket_action_listview.dart';
import '../../../domain/entities/bucket_action.dart';
import '../../../data/repositories/bucket_action_repository.dart';
import '../../../data/repositories/bucket_repository.dart';
import '../../../domain/domain_rules/solve_challenge.dart';
import '../../../domain/repositories/bucket_action_repository.dart';
import '../../../domain/repositories/bucket_repository.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageBodyState();
}

class HomePageBodyState extends State<HomePageBody> {
  final TextEditingController bucketOneTextFieldController = TextEditingController();
  final TextEditingController bucketTwoTextFieldController = TextEditingController();
  final TextEditingController waterAmountTextFieldController = TextEditingController();

  final BucketRepository bucketRepository = BucketRepositoryImpl();
  final BucketActionRepository actionRepository = BucketActionRepositoryImpl();

  List<BucketAction>? actionsList = [];

  void onCalculatePressed() {
    SolveChallenge(bucketRepository, actionRepository)
        .call(
            bucketOneCapacity: int.parse(bucketOneTextFieldController.text),
            bucketTwoCapacity: int.parse(bucketTwoTextFieldController.text),
            amountWanted: int.parse(waterAmountTextFieldController.text))
        .then((value) {
      setState(() {
        actionsList = value;
      });
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Welcome!',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text('Please, insert the bucket sizes and the desired amount of water to be stored in one of them.'),
          const SizedBox(
            height: 32.0,
          ),
          const Text(
            'Bucket volumes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: bucketOneTextFieldController,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: '0',
                      labelText: 'Bucket A',
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: bucketTwoTextFieldController,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: '0',
                      labelText: 'Bucket B',
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 24.0,
          ),
          const Text('Desired amount of water', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: waterAmountTextFieldController,
              keyboardType: TextInputType.number,
              maxLength: 2,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                hintText: '0',
                labelText: 'Water amount',
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Center(
              child: TextButton(
            onPressed: onCalculatePressed,
            child: const Text('Calculate steps'),
            style: TextButton.styleFrom(elevation: 2),
          )),
          const Divider(
            height: 64.0,
            thickness: 1,
          ),
          const Text(
            'Results',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Flexible(child: Center(child: Text('Content', style: TextStyle(fontWeight: FontWeight.bold))), flex: 1,),
                Flexible(child: Center(child: Text('Content', style: TextStyle(fontWeight: FontWeight.bold))), flex: 1,),
                Flexible(child: Center(child: Text('Explanation', style: TextStyle(fontWeight: FontWeight.bold),)), flex: 1,),
              ],
            ),
          ),
          const Divider(
            height: 8.0,
            thickness: 1,
          ),
          if (actionsList != null)
            actionsList!.isEmpty
              ? const Text('No actions')
              : BucketActionListView(actionsList: actionsList!,)
          else
            const Text('No solution')
        ],
      ),
    );
  }
}
