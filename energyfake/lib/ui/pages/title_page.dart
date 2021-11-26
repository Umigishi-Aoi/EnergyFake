
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dialog/how_to_use_dialog.dart';
import '../../state/page_state.dart';

class TitlePage extends ConsumerWidget {
  const TitlePage({Key? key}) : super(key: key);

  static const double _topMarginRatio = 0.05;
  static const double _titleHeightRatio = 0.25;
  static const double _startButtonHeightRatio = 0.1;
  static const double _startButtonWidthRatio = 0.7;
  static const double _buttonHeightRatio = 0.05;
  static const double _buttonWidthRatio = 0.4;
  static const double _buttonMarginRatio = 0.1;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/title_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: height * _topMarginRatio,
                  ),
                  SizedBox(
                    height: height * _titleHeightRatio,
                    child: Image.asset(
                      "images/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * _startButtonHeightRatio,
                    width: width * _startButtonWidthRatio,
                    child: ElevatedButton(
                      onPressed: () async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        if(prefs.getString('howToUseDone') == null) {
                          showHowToUseDialog(context);
                        }
                        ref.read(pageStateProvider.state).state = PageState.main;
                      },
                      child: Text(
                        AppLocalizations.of(context)!.start,
                        style: const TextStyle(
                          fontSize: 48,
                        ),
                      ),

                    ),
                  ),
                  SizedBox(
                    height: height * _buttonMarginRatio,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: height * _buttonHeightRatio,
                          width: width * _buttonWidthRatio,
                          child: ElevatedButton(
                            onPressed: () {
                              showHowToUseDialog(context);
                            },
                            child: Text(AppLocalizations.of(context)!.howToUse),
                          ),
                        ),
                        SizedBox(
                          height: height * _buttonHeightRatio,
                          width: width * _buttonWidthRatio,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(AppLocalizations.of(context)!.disclaimer),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * _buttonMarginRatio,
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
