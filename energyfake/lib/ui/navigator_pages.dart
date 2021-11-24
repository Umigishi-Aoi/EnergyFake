import 'package:flutter/material.dart';

import 'pages/title_page.dart';

class NavigatorPages extends StatelessWidget {
  const NavigatorPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        pages: const [
          MaterialPage(
            child: TitlePage(),
          ),
        ],
        onPopPage: (route, result) {
          return false;
        });
  }
}
