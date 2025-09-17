import 'package:batrina/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          loc!.hello,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
        ),
      ),
    );
  }
}
