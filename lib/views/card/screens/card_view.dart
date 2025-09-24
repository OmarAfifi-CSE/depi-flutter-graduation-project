import 'package:flutter/material.dart';
import 'package:batrina/views/card/widget/card_body.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: CardViewBody(),
      ),
    );
  }
}
