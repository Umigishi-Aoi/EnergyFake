import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../res/colors.dart';
import '../../state/page_state.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      onLongPress: (){
        ref.read(pageStateProvider.state).state = PageState.title;
      },

      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: mainPageBackground,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset("images/battery_empty.png"),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset("images/energy_cord.png"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
