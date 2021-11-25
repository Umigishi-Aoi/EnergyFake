import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/main_page.dart';
import 'pages/title_page.dart';
import '../state/page_state.dart';


class NavigatorPages extends ConsumerWidget {
  const NavigatorPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Navigator(
        pages: [
          const MaterialPage(
            child: TitlePage(),
          ),
          if(ref.watch(pageStateProvider) == PageState.main)
            const MaterialPage(
              child: MainPage(),
            ),
        ],
        onPopPage: (route, result) {
          return false;
        });
  }
}
