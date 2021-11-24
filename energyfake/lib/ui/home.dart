import 'package:flutter/material.dart';

import 'navigator_pages.dart';
import '../res/theme.dart';

class EnergyFake extends StatelessWidget {
  const EnergyFake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: const NavigatorPages(),
    );
  }
}

