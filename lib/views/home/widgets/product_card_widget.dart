import 'package:flutter/cupertino.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                  image: AssetImage("assets/1.png"), fit: BoxFit.cover)),
        ),
        const Column(
          children: [
            Text(
              "title",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "description",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "200\$",
              style: TextStyle(fontSize: 20),
            )
          ],
        )
      ],
    );
  }
}
