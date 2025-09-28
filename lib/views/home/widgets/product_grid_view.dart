import 'package:batrina/models/product_model.dart';
import 'package:batrina/views/home/widgets/product_card_widget.dart' show ProductCardWidget;
import 'package:flutter/material.dart';


final List<Product> products = [
  Product(
    name: 'Roller Rabbit',
    brand: 'Vinca Jogger',
    price: 198.00,
    imageUrl:
        'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=300&h=400&fit=crop',
    isSelected: true,
  ),
  Product(
    name: 'endless rose',
    brand: 'Button Up Shirt',
    price: 50.00,
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=300&h=400&fit=crop',
  ),
  Product(
    name: 'Theory',
    brand: 'Regular Fit T-Shirt',
    price: 345.00,
    imageUrl:
        'https://images.unsplash.com/photo-1583744946564-b52ac1c389c8?w=300&h=400&fit=crop',
  ),
  Product(
    name: 'Madewell',
    brand: 'Galsier Top in Wkdn Blnc',
    price: 69.50,
    imageUrl:
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=300&h=400&fit=crop',
  ),
  Product(
    name: 'Summer Vibes',
    brand: 'Casual Beach Dress',
    price: 89.99,
    imageUrl:
        'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=300&h=400&fit=crop',
  ),
  Product(
    name: 'Urban Style',
    brand: 'Black Hoodie',
    price: 125.00,
    imageUrl:
        'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=300&h=400&fit=crop',
  ),
];

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 15,
          mainAxisSpacing: 30,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return const ProductCardWidget();
        },
      ),
    );
  }
}
