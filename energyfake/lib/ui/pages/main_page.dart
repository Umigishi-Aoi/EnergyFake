import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
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

  //充電状態の検知のために、バッテリー関連フィールドを設定
  final Battery _battery = Battery();

  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  static const double _batteryPictureWidthRatio = 0.35;
  static const double _cordPictureHeightRatio = 0.25;

  @override
  void initState() {
    _ctrl = AnimationController(duration: duration, vsync: this)
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _ctrl.reverse();
            _batteryFlag = true;
          });
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            _ctrl.forward();
            _batteryFlag = false;
            _blackoutCounter++;
          });
        }
      });

    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        _batteryState = state;
        _blackoutCounter = 0;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (_blackoutCounter >= _blackoutTrigger) {
          setState(() {
            _blackoutCounter = 0;
          });
        }
      },
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
                    if (_batteryState == BatteryState.charging ||
                        _batteryState == BatteryState.full)
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: width * _batteryPictureWidthRatio,
                              child: Image.asset(
                                "images/battery_low.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      )
                    else
                      Stack(
                        children: [
                          if (_batteryFlag)
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: width * _batteryPictureWidthRatio,
                                child: Image.asset(
                                  "images/battery_low.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          else
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: width * _batteryPictureWidthRatio,
                                child: Image.asset(
                                  "images/battery_empty.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: height * _cordPictureHeightRatio,
                              child: Image.asset(
                                "images/energy_cord.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
