import 'package:batrina/controllers/cubit/profile/add_address_cubit/add_address_cubit.dart';
import 'package:batrina/controllers/cubit/profile/get_addresses_cubit/get_addresses_cubit.dart';
import 'package:batrina/models/address_model.dart';
import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';
import 'package:batrina/views/auth/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController street = TextEditingController();

  final TextEditingController city = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController country = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? streetValidation(String? value) {
    final loc = AppLocalizations.of(context);
    if (value == null || value.trim().isEmpty) {
      return loc!.streetEmptyDescription; // "Street address is required"
    }
    if (value.trim().length < 5) {
      return loc!.streetTooShortDescription; // "Street address is too short"
    }
    return null;
  }

  String? cityValidation(String? value) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.trim().isEmpty) {
      return loc!.cityEmptyDescription; // "City is required"
    }
    if (value.trim().length < 2) {
      return loc!.cityTooShortDescription; // "City name is too short"
    }
    return null;
  }

  String? countryValidation(String? value) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.trim().isEmpty) {
      return loc!.countryEmptyDescription; // "Country is required"
    }
    if (value.trim().length < 2) {
      return loc!.countryTooShortDescription; // "Country name is too short"
    }
    return null;
  }

  String? phoneNumberValidation(String? value) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.trim().isEmpty) {
      return loc!.phoneEmptyDescription; // "Phone number is required"
    }

    // إزالة المسافات والرموز
    final cleanedPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // التحقق من أن كل الأحرف أرقام
    if (!RegExp(r'^[0-9+]+$').hasMatch(cleanedPhone)) {
      return loc!
          .phoneInvalidDescription; // "Phone number must contain only numbers"
    }

    // التحقق من الطول (من 8 لـ 15 رقم)
    if (cleanedPhone.length < 8 || cleanedPhone.length > 15) {
      return loc!
          .phoneLengthDescription; // "Phone number must be between 8 and 15 digits"
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => AddAddressCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomHeaderWidget(prefix: BackArrow()),
                SizedBox(height: 15.h),
                CustomText(
                  data: "addNewAddress",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 15.h),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        controller: street,
                        labelText: "Street",
                        validator: streetValidation,
                      ),
                      SizedBox(height: 20.h),
                      CustomTextFormField(
                        controller: city,
                        labelText: "City",
                        validator: cityValidation,
                      ),
                      SizedBox(height: 20.h),
                      CustomTextFormField(
                        controller: phoneNumber,
                        labelText: "PhoneNumber",
                        validator: phoneNumberValidation,
                      ),
                      SizedBox(height: 20.h),
                      CustomTextFormField(
                        controller: country,
                        labelText: "Country",
                        validator: countryValidation,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                BlocConsumer<AddAddressCubit, AddAddressState>(
                  listener: (context, state) {
                    if (state is AddAddressSuccess) {
                      CustomSnackBar.showSnackBar(
                        context: context,
                        message: "Address added successfully",
                        color: Colors.green,
                      );

                      context.read<GetAddressesCubit>().getAddresses();
                      context.pop();
                    } else if (state is AddAddressFailure) {
                      CustomSnackBar.showSnackBar(
                        context: context,
                        message: state.error,
                        color: Colors.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      onPressed: state is! AddAddressLoading
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AddAddressCubit>().addAddress(
                                  address: AddressModel(
                                    id: "",
                                    street: street.text.trim(),
                                    city: city.text.trim(),
                                    phoneNumber: phoneNumber.text.trim(),
                                    country: country.text.trim(),
                                  ),
                                );
                              }
                            }
                          : () {},
                      buttonChild: state is! AddAddressLoading
                          ? CustomText(
                              data: "addAddress",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: theme.scaffoldBackgroundColor,
                            )
                          : CupertinoActivityIndicator(
                              color: theme.scaffoldBackgroundColor,
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
