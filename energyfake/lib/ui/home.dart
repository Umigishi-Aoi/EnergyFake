import 'package:flutter/material.dart';

import 'navigator_pages.dart';

class EnergyFake extends StatelessWidget {
  const EnergyFake({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: NavigatorPages(),
    );
  }
}