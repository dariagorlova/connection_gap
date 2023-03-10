import 'package:flutter/material.dart';

class IndependentScreen extends StatelessWidget {
  const IndependentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Some screen title'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Congrats, you are here :)'),
        ),
      ),
    );
  }
}
