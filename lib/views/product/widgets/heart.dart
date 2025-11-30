import 'package:batrina/controllers/cubit/profile/get_wish_list_cubit/get_wish_list_cubit.dart';
import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/wish_list_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class Heart extends StatefulWidget {
  const Heart({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  bool isClickable = true;
  bool loading = true;
  bool isAdded = false;
  List<WishlistModel> userWishList = [];

  @override
  void initState() {
    checkIfItAdded();
    super.initState();
  }

  void checkIfItAdded() async {
    FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

    try {
      userWishList = await fireBaseFireStore.getWishList();
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = true;
      });
    }
  }

  Future toggleButton() async {
    FireBaseFireStore fireBaseFireStore = FireBaseFireStore();
    ProductVariant? productVariant = context.read<ProductProvider>().variant;

    if (isAdded) {
      setState(() {
        isAdded = false;
        isClickable = false;
      });

      try {
        final wishlistModels = userWishList.where((element) {
          return element.variantId == productVariant?.id;
        });
        if (wishlistModels.isNotEmpty) {
          await fireBaseFireStore.removeFromWishList(
            wishListModel: wishlistModels.first,
          );
          final router = GoRouter.of(context);
          final matches = router.routerDelegate.currentConfiguration.matches;

          bool wishScreenExists = matches.any((match) {
            final route = match.route;

            if (route is GoRoute) {
              return route.name == AppRoutes.wishlistScreen;
            }
            return false;
          });
          print(wishScreenExists.toString() + "abolo");
          if (wishScreenExists) {
            context.read<GetWishListCubit>().removeLocal(
              wishlistModels.first.id,
            );
          }
          userWishList.remove(wishlistModels.first);
        }
      } catch (e) {
        isAdded = true;
      }
      setState(() {
        isClickable = true;
      });
    } else {
      setState(() {
        isAdded = true;
        isClickable = false;
      });
      try {
        WishlistModel wishlistModel = WishlistModel(
          id: '',
          productId: widget.productModel.id,
          productName: widget.productModel.name,
          subtitle: widget.productModel.subtitle,
          categoryName: widget.productModel.categoryName,
          price: widget.productModel.price,
          thumbnail: widget.productModel.thumbnail,
          variantId: productVariant?.id ?? '',
          color: productVariant?.color ?? '',
          size: productVariant?.size ?? '',
          availableStock: context.read<ProductProvider>().currentVariantStock,
          addedAt: null,
        );

        String newWishListId = await fireBaseFireStore.addToWishList(
          wishListModel: wishlistModel,
        );
        userWishList.add(wishlistModel.copyWith(id: newWishListId));
        final router = GoRouter.of(context);
        final matches = router.routerDelegate.currentConfiguration.matches;

        bool wishScreenExists = matches.any((match) {
          final route = match.route;

          if (route is GoRoute) {
            return route.name == AppRoutes.wishlistScreen;
          }
          return false;
        });
        print(wishScreenExists.toString() + "abolo");

        if (wishScreenExists) {
          context.read<GetWishListCubit>().addLocal(
            wishlistModel.copyWith(id: newWishListId),
          );
        }
      } catch (e) {
        isAdded = false;
      }
      setState(() {
        isClickable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ProductProvider productProvider = context.watch<ProductProvider>();
    final wishlistModels = userWishList.where((element) {
      return element.variantId == productProvider.variant?.id;
    });
    print(productProvider.variant!.id);
    if (wishlistModels.isNotEmpty) {
      isAdded = true;
    } else {
      isAdded = false;
    }
    return !productProvider.preview
        ? AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            opacity: loading == true ? 0 : 1,
            child: GestureDetector(
              onTap: isClickable
                  ? () {
                      toggleButton();
                    }
                  : () {},
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),

                child: Padding(
                  padding: EdgeInsets.all(7.5.w),
                  child:
                      SvgPicture.asset(
                            key: ValueKey(isAdded),
                            isAdded
                                ? AppAssets.heartIconFilled
                                : AppAssets.heartIcon,
                            width: 20.w,
                            height: 20.w,
                            colorFilter: isAdded
                                ? null
                                : ColorFilter.mode(
                                    theme.primaryColor,
                                    BlendMode.srcIn,
                                  ),
                            fit: BoxFit.scaleDown,
                          )
                          .animate(key: ValueKey(isAdded))
                          .scale(
                            duration: const Duration(milliseconds: 300),
                            begin: const Offset(.6, .6),
                            end: const Offset(1.3, 1.3),
                            curve: Curves.elasticOut,
                          ),
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(7.5.w),
              child:
                  SvgPicture.asset(
                        key: ValueKey(isAdded),
                        AppAssets.heartIconFilled,
                        width: 20.w,
                        height: 20.w,
                        colorFilter: null,

                        fit: BoxFit.scaleDown,
                      )
                      .animate(key: ValueKey(isAdded))
                      .scale(
                        duration: const Duration(milliseconds: 300),
                        begin: const Offset(.6, .6),
                        end: const Offset(1.3, 1.3),
                        curve: Curves.elasticOut,
                      ),
            ),
          );
  }
}
