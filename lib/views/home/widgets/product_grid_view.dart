import 'package:batrina/models/product_model.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/views/categories/category_products/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// final List<Product> products = [
//   Product(
//     name: 'Roller Rabbit',
//     brand: 'Vinca Jogger',
//     price: 198.00,
//     imageUrl: AppAssets.categoryTestImage,
//   ),
//   Product(
//     name: 'endless rose',
//     brand: 'Button Shirt',
//     price: 50.00,
//     imageUrl: AppAssets.categoryTestImage,
//   ),
//   Product(
//     name: 'Theory',
//     brand: 'T-Shirt',
//     price: 345.00,
//     imageUrl: AppAssets.categoryTestImage,
//   ),
//   Product(
//     name: 'Madewell',
//     brand: 'Galsier Top',
//     price: 69.50,
//     imageUrl: AppAssets.categoryTestImage,
//   ),
//   Product(
//     name: 'Summer Vibes',
//     brand: 'Casual Dress',
//     price: 89.99,
//     imageUrl: AppAssets.categoryTestImage,
//   ),
//   Product(
//     name: 'Urban Style',
//     brand: 'Black Hoodie',
//     price: 125.00,
//     imageUrl: AppAssets.categoryTestImage,
//   ),
//   Product(
//     name: 'Roller Rabbit',
//     brand: 'Vinca Jogger',
//     price: 198.00,
//     imageUrl: AppAssets.categoryTestImage,
//   ),
//   Product(
//     name: 'endless rose',
//     brand: 'Button Shirt',
//     price: 50.00,
//     imageUrl: AppAssets.categoryTestImage,
//   ),
//   Product(
//     name: 'Theory',
//     brand: 'T-Shirt',
//     price: 345.00,
//     imageUrl: AppAssets.categoryTestImage,
//   ),
//   Product(
//     name: 'Madewell',
//     brand: 'Galsier Top ',
//     price: 69.50,
//     imageUrl: AppAssets.categoryTestImage,
//   ),
// ];

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 18.w,
        mainAxisSpacing: 20.h,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        //Product pr = products[index];
        return Container(
          height: 100.h,
          color: Colors.black,
          child: Icon(Icons.ac_unit, color: Colors.white),
        );
        // ProductCardWidget(
        //   price: pr.price,
        //   desc: pr.name,
        //   brand: pr.brand,
        //   img: pr.imageUrl,
        // );
      },
    );
  }
}
