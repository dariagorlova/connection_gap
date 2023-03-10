import 'package:flutter/material.dart';

Future<dynamic> checkInternetConnectionDlg(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('No Connection'),
        content: _bodyWidget(),
      );
    },
  );
}

Widget _bodyWidget() {
  return const Text('Please check your internet connectivity');
}
