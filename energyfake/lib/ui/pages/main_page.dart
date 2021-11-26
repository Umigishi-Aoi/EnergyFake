import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../res/colors.dart';
import '../../state/page_state.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  final duration = const Duration(seconds: 1);
  late AnimationController _ctrl;

  //画像切り替え用フラグ
  bool _batteryFlag = false;

  //画面非表示にするためのパラメータ
  int _blackoutCounter = 0;
  //点滅何セットで画面非表示にするか
  static const int _blackoutTrigger = 5;

  @override
  void initState() {
    _ctrl = AnimationController(duration: duration, vsync: this)
      ..addListener(() => setState(() {}))
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _ctrl.reverse();
          _batteryFlag = true;
        } else if (status == AnimationStatus.dismissed) {
          _ctrl.forward();
          _batteryFlag = false;
          _blackoutCounter++;
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onLongPress: () {
        ref.read(pageStateProvider.state).state = PageState.title;
      },
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: mainPageBackground,
          body: Stack(
            children: [
              if (_blackoutCounter < _blackoutTrigger)
                Stack(
                  children: [
                    if (_batteryFlag)
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset("images/battery_low.png"),
                      )
                    else
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
            ],
          ),
        ),
      ),
    );
  }
}
