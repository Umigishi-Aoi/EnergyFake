import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/home.dart';

void main() {
  runApp(const ProviderScope(child: EnergyFake()));
}