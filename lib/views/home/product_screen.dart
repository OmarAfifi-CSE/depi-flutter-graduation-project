import 'package:batrina/views/home/widgets/product_grid_view.dart' show ProductGridView;
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25,),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Clothes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 18),
          ProductGridView(),
        ],
      ),
    );
  }
}
