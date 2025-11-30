import 'package:batrina/controllers/cubit/profile/get_wish_list_cubit/get_wish_list_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/categories/widgets/search_bar.dart';
import 'package:batrina/views/profile/wishlist/widgets/empty_wish_list_view.dart';
import 'package:batrina/views/profile/wishlist/widgets/wish_list_row.dart';
import 'package:batrina/views/profile/wishlist/widgets/wish_list_search_field.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistBody extends StatefulWidget {
  const WishlistBody({super.key});

  @override
  State<WishlistBody> createState() => _WishlistBodyState();
}

class _WishlistBodyState extends State<WishlistBody> {
  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        // Search bar
        SearchBarWidget(
          onChanged: (text) {
            setState(() {
              _searchText = text;
            });
          },
        ),
        // Wishlist items
        Expanded(
          child: BlocBuilder<GetWishListCubit, GetWishListState>(
            builder: (context, state) {
              if (state is GetWishListFailure) {
                return Center(
                  child: CustomText(
                    data: state.error,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                );
              } else if (state is GetWishListLoading) {
                return Center(
                  child: CupertinoActivityIndicator(color: theme.primaryColor),
                );
              }
              final allWishList = (state as GetWishListSuccess).userWishList;
              final filteredList = allWishList.where((item) {
                return item.productName.toLowerCase().contains(
                  _searchText.toLowerCase(),
                );
              }).toList();

              return filteredList.isNotEmpty
                  ? ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Divider(
                                color: appColors.dividerColor,
                                thickness: 1.h,
                                height: 1.h,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return WishListRow(
                          key: ValueKey(filteredList[index].id),
                          wishlistModel: filteredList[index],
                        );
                      },
                    )
                  : Center(
                      child: !_searchText.isEmpty
                          ? CustomText(
                              data: loc!.noItemsMatchSearch,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            )
                          : const EmptyWishListView(),
                    );
            },
          ),
        ),
      ],
    );
  }
}
