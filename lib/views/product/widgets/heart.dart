import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    checkIfItAdded();
    super.initState();
  }

  void checkIfItAdded() async {
    FireBaseFireStore fireBaseFireStore = FireBaseFireStore();
    try {
      isAdded = await fireBaseFireStore.checkIfItInFav(
        productModel: widget.productModel,
      );
      setState(() {
        loading = false;
      });
    } catch (e) {
      loading = true;
    }
  }

  Future toggleButton() async {
    FireBaseFireStore fireBaseFireStore = FireBaseFireStore();
    if (isAdded) {
      setState(() {
        isAdded = false;
        isClickable = false;
      });
      try {
        await fireBaseFireStore.removeFromWishList(
          productModel: widget.productModel,
        );
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
        await fireBaseFireStore.addToWishList(
          productModel: widget.productModel,
        );
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
    return AnimatedOpacity(
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

                      isAdded ? AppAssets.heartIconFilled : AppAssets.heartIcon,
                      width: 20.w,
                      height: 20.w,
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
    );
  }
}
