import 'package:connection_gap/navigation.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('first screen data'),
          ElevatedButton(
              onPressed: NavigationActions.instance.onIndependentScreen,
              child: const Text('some screen')),
        ],
      ),
    );
  }
}
