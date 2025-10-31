import 'package:batrina/controllers/cubit/cart/get_cart_cubit/get_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:batrina/views/cart/widget/cart_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<GetCartCubit>().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CartViewBody();
  }
}
