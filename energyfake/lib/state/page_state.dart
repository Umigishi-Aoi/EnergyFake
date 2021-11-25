import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PageState{
  title,
  main,
}

final pageStateProvider = StateProvider<PageState>((ref)=> PageState.title);