import 'package:flutter/material.dart';
import 'package:batrina/views/item/widgets/item_body.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.white, body: ItemBody());
  }
}
