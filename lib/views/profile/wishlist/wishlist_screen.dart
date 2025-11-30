import 'package:batrina/controllers/cubit/profile/get_wish_list_cubit/get_wish_list_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/views/profile/wishlist/widgets/wishlist_body.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetWishListCubit>().getWishList();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: CustomHeaderWidget(
            center: CustomText(
              data: loc!.wishlist,
              textAlign: TextAlign.center,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
            prefix: const BackArrow(),
          ),
          leading: const SizedBox(),
          leadingWidth: 0,
        ),
        body: const WishlistBody(),
      ),
    );
  }
}
