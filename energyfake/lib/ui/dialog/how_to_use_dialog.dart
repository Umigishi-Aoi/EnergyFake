import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showHowToUseDialog(BuildContext context){

  showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Center(
        child: Text(
          AppLocalizations.of(context)!.howToUse,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      content: Builder(
        builder: (context) {
          return SizedBox(
            child: SingleChildScrollView(
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.howToUseContents,
                ),
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if(prefs.getString('howToUseDone') == null) {
                await prefs.setString('howToUseDone', "Done");
              }
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.back),
          ),
        )
      ],
    ),
  );
}