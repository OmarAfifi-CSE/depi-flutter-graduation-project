import 'package:batrina/controllers/cubit/profile/add_address_cubit/add_address_cubit.dart';
import 'package:batrina/controllers/cubit/profile/get_addresses_cubit/get_addresses_cubit.dart';
import 'package:batrina/models/address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text_form_field.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController street = TextEditingController();

  final TextEditingController city = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController country = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? streetValidation(String? value) {
    final loc = AppLocalizations.of(context);
    if (value == null || value.trim().isEmpty) {
      return loc!.streetEmptyDescription;
    }
    if (value.trim().length < 5) {
      return loc!.streetTooShortDescription;
    }
    return null;
  }

  String? cityValidation(String? value) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.trim().isEmpty) {
      return loc!.cityEmptyDescription;
    }
    if (value.trim().length < 2) {
      return loc!.cityTooShortDescription;
    }
    return null;
  }

  String? countryValidation(String? value) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.trim().isEmpty) {
      return loc!.countryEmptyDescription;
    }
    if (value.trim().length < 2) {
      return loc!.countryTooShortDescription;
    }
    return null;
  }

  String? phoneNumberValidation(String? value) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.trim().isEmpty) {
      return loc!.phoneEmptyDescription;
    }

    final cleanedPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (!RegExp(r'^[0-9+]+$').hasMatch(cleanedPhone)) {
      return loc!.phoneInvalidDescription;
    }

    // التحقق من الطول (من 8 لـ 15 رقم)
    if (cleanedPhone.length < 8 || cleanedPhone.length > 15) {
      return loc!.phoneLengthDescription;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => AddAddressCubit()..loc = loc,
      child: Scaffold(
        appBar: AppBar(
          title: CustomHeaderWidget(
            center: CustomText(
              data: loc!.addNewAddress,
              textAlign: TextAlign.center,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
            prefix: const BackArrow(),
          ),
          leading: const SizedBox(),
          leadingWidth: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 25.h),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextFormField(
                                controller: street,
                                labelText: loc.street,
                                validator: streetValidation,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextFormField(
                                controller: city,
                                labelText: loc.city,
                                validator: cityValidation,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextFormField(
                                controller: phoneNumber,
                                labelText: loc.phoneNumber,
                                validator: phoneNumberValidation,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextFormField(
                                controller: country,
                                labelText: loc.country,
                                validator: countryValidation,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                BlocConsumer<AddAddressCubit, AddAddressState>(
                  listener: (context, state) {
                    if (state is AddAddressSuccess) {
                      CustomSnackBar.showSnackBar(
                        context: context,
                        message: loc.addressAddedSuccessfully,
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
                              FocusScope.of(context).unfocus();
                            }
                          : () {},
                      buttonChild: state is! AddAddressLoading
                          ? CustomText(
                              data: loc.addAddress,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: theme.scaffoldBackgroundColor,
                            )
                          : CupertinoActivityIndicator(
                              color: theme.scaffoldBackgroundColor,
                            ),
                    );
                  },
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
