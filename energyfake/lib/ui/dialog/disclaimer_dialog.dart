import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showDisclaimerDialog(BuildContext context){

  showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Center(
        child: Text(
          AppLocalizations.of(context)!.disclaimer,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      content: Builder(
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height*0.4,
            child: SingleChildScrollView(
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.disclaimerContents,
                ),
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:
            Text(AppLocalizations.of(context)!.back),
          ),
        )
      ],
    ),
  );
}