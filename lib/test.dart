import 'package:batrina/controllers/locale_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(children: [Text(loc!.hello), Text(loc.welcome)]),
            ElevatedButton(
              onPressed: () {
                context.read<LocaleProvider>().changeLocale("ar");
              },
              child: Text("change"),
            ),
          ],
        ),
      ),
    );
  }
}
