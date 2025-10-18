import 'package:batrina/controllers/cubit/profile/get_addresses_cubit/get_addresses_cubit.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/profile/widgets/add_address_container.dart';
import 'package:batrina/views/profile/widgets/address_card.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/address_model.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String? mainAddress;
  bool allowVertical = true;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => GetAddressesCubit()..getAddresses(),
      child: BlocConsumer<GetAddressesCubit, GetAddressesState>(
        listener: (context, state) {
          if (state is GetAddressesSuccess) {
            if (mounted) {
              setState(() {
                mainAddress = FireBaseFireStore.currentUser?.mainAddressId;
                allowVertical = true;
              });
            }
          }
        },
        builder: (context, state) {
          if (state is GetAddressesLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is GetAddressesFailure) {
            return const Center(child: Text("error"));
          }
          List<AddressModel> addresses =
              (state as GetAddressesSuccess).addresses;
          AddressModel? mainAddressModel;

          if (mainAddress != null && addresses.isNotEmpty) {
            try {
              mainAddressModel = addresses.firstWhere(
                (element) => element.id == mainAddress,
              );
            } catch (e) {
              mainAddressModel = null;
            }
          }
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.0.w,
                  vertical: 25.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomHeaderWidget(prefix: BackArrow()),
                    SizedBox(height: 20.h),
                    CustomText(
                      data: "main Address",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 200.h,
                      child: AddressCard(addressModel: mainAddressModel),
                    ),
                    const Spacer(),
                    CustomText(
                      data: "Other Addresses",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 20.h),

                    addresses.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      size: 16.sp,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 6.w),
                                    CustomText(
                                      data: "Set Main",
                                      fontSize: 12.sp,
                                      color: appColors.secondaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      size: 16.sp,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 6.w),
                                    CustomText(
                                      data: "Delete",
                                      fontSize: 12.sp,
                                      color: appColors.secondaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),

                    addresses.isNotEmpty
                        ? SizedBox(height: 80.h)
                        : const SizedBox(),

                    SizedBox(
                      height: 200.h,
                      child: CardSwiper(
                        key: ValueKey(addresses.length),
                        cardsCount: addresses.length + 1,
                        allowedSwipeDirection: AllowedSwipeDirection.only(
                          left: addresses.isEmpty ? false : true,
                          right: addresses.isEmpty ? false : true,
                          up: addresses.isEmpty ? false : allowVertical,
                          down: addresses.isEmpty ? false : allowVertical,
                        ),
                        isLoop: true,
                        numberOfCardsDisplayed: addresses.isEmpty
                            ? 1
                            : addresses.length >= 3
                            ? 3
                            : addresses.length + 1,
                        backCardOffset: const Offset(0, -50),
                        padding: EdgeInsetsGeometry.zero,
                        onSwipe: (previousIndex, currentIndex, direction) {
                          // Swipe Down - Delete
                          if (direction == CardSwiperDirection.bottom &&
                              previousIndex < addresses.length) {
                            final addressToDelete = addresses[previousIndex];

                            // لو العنوان المحذوف كان هو الـ main، خليه null
                            if (mainAddress == addressToDelete.id) {
                              mainAddress = null;

                              // خلي الـ callback يخلص الأول، وبعدين احذف من local وبعدين Firebase
                              WidgetsBinding.instance.addPostFrameCallback((
                                _,
                              ) async {
                                if (mounted) {
                                  // حذف من local أولاً (UI updates)
                                  context
                                      .read<GetAddressesCubit>()
                                      .removeFromLocal(
                                        address: addressToDelete,
                                      );

                                  // حذف من Firebase
                                  try {
                                    await FireBaseFireStore()
                                        .removeMainAddressForUser(
                                          address: addressToDelete,
                                        );
                                    FireBaseFireStore
                                            .currentUser
                                            ?.mainAddressId =
                                        null;
                                  } catch (e) {
                                    debugPrint(
                                      "❌ Error removing main address: $e",
                                    );
                                  }

                                  try {
                                    await FireBaseFireStore().removeAddress(
                                      address: addressToDelete,
                                    );
                                    debugPrint(
                                      "✅ Address deleted successfully",
                                    );
                                  } catch (e) {
                                    debugPrint(
                                      "❌ Error deleting from Firebase: $e",
                                    );
                                  }
                                }
                              });
                            } else {
                              // لو مش الـ main address
                              WidgetsBinding.instance.addPostFrameCallback((
                                _,
                              ) async {
                                if (mounted) {
                                  // حذف من local أولاً
                                  context
                                      .read<GetAddressesCubit>()
                                      .removeFromLocal(
                                        address: addressToDelete,
                                      );

                                  // حذف من Firebase
                                  try {
                                    await FireBaseFireStore().removeAddress(
                                      address: addressToDelete,
                                    );
                                    debugPrint(" Address deleted successfully");
                                  } catch (e) {
                                    debugPrint(
                                      " Error deleting from Firebase: $e",
                                    );
                                  }
                                }
                              });
                            }
                          }
                          // Swipe Up - Set as Main
                          else if (direction == CardSwiperDirection.top &&
                              previousIndex < addresses.length) {
                            final addressToSetMain = addresses[previousIndex];

                            if (mounted) {
                              setState(() {
                                mainAddress = addressToSetMain.id;
                              });
                            }

                            // تحديث Firebase في الـ background
                            FireBaseFireStore()
                                .addMainAddressForUser(
                                  address: addressToSetMain,
                                )
                                .then((_) {
                                  FireBaseFireStore.currentUser?.mainAddressId =
                                      addressToSetMain.id;
                                })
                                .catchError((e) {
                                  debugPrint(" Error setting main address: $e");
                                });
                          }

                          // تحديث allowVertical بناءً على الـ index الجديد
                          if (currentIndex != null) {
                            // لو delete operation، استنى الـ state يتحدث
                            if (direction == CardSwiperDirection.bottom &&
                                previousIndex < addresses.length) {
                              WidgetsBinding.instance.addPostFrameCallback((
                                _,
                              ) async {
                                if (mounted) {
                                  final cubitState = context
                                      .read<GetAddressesCubit>()
                                      .state;
                                  if (cubitState is GetAddressesSuccess) {
                                    final updatedAddresses =
                                        cubitState.addresses;

                                    // امنع vertical بس لو مفيش عناوين خالص
                                    if (updatedAddresses.isEmpty) {
                                      setState(() {
                                        allowVertical = false;
                                      });
                                    } else if (!allowVertical) {
                                      setState(() {
                                        allowVertical = true;
                                      });
                                    }
                                  }
                                }
                              });
                            } else {
                              // لو swipe عادي (يمين/شمال/فوق)، حدث على طول
                              final cubitState = context
                                  .read<GetAddressesCubit>()
                                  .state;
                              if (cubitState is GetAddressesSuccess) {
                                final updatedAddresses = cubitState.addresses;

                                // لو وصلنا للـ Add card، امنع vertical
                                if (currentIndex >= updatedAddresses.length) {
                                  if (allowVertical && mounted) {
                                    setState(() {
                                      allowVertical = false;
                                    });
                                  }
                                } else {
                                  if (!allowVertical && mounted) {
                                    setState(() {
                                      allowVertical = true;
                                    });
                                  }
                                }
                              }
                            }
                          }

                          return true;
                        },
                        cardBuilder:
                            (
                              context,
                              index,
                              percentThresholdX,
                              percentThresholdY,
                            ) {
                              return addresses.isNotEmpty
                                  ? index < addresses.length
                                        ? AddressCard(
                                            addressModel: addresses[index],
                                          )
                                        : const AddAddressContainer()
                                  : const AddAddressContainer();
                            },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
