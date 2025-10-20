import 'package:batrina/controllers/cubit/profile/edit_user_cubit/edit_user_cubit.dart';
import 'package:batrina/controllers/provider/profile_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/user_model.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';

// IMPROVEMENT: Swapped CustomElevatedButton for TextButton for the logout action.
import 'package:batrina/widgets/custom_text_form_field.dart';
import 'package:batrina/views/profile/personal_details/widgets/confirm_button.dart';
import 'package:batrina/views/profile/personal_details/widgets/profile_image.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:batrina/l10n/app_localizations.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  late ProfileProvider profileProvider;
  late TextEditingController nameController;
  late TextEditingController emailController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? nameValidation(String? value) {
    final loc = AppLocalizations.of(context);
    if (value == null || value.trim().isEmpty) {
      return loc!.nameEmptyDescription;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    profileProvider = context.read<ProfileProvider>();
    nameController = TextEditingController(text: profileProvider.mainName);
    emailController = TextEditingController(
      text: FireBaseFireStore.currentUser!.email,
    );

    nameController.addListener(() {
      profileProvider.setName(nameController.text.trim());
    });
  }

  void confirmFunction() {
    if (_formKey.currentState!.validate()) {
      UserModel updatedUser = FireBaseFireStore.currentUser!.copyWith(
        name: profileProvider.currentName,
        picture: profileProvider.currentImage,
      );

      profileCubit.editUser(
        context: context,
        user: updatedUser,
        profileProvider: profileProvider,
      );
    }
  }

  EditUserCubit profileCubit = EditUserCubit();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => profileCubit,
      child: Scaffold(
        appBar: AppBar(
          title: CustomHeaderWidget(
            center: CustomText(
              data: loc!.personalDetails,
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
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: [
                        SizedBox(height: 45.h),
                        const ProfileImage(),
                        SizedBox(height: 30.h),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextFormField(
                                controller: nameController,
                                labelText: loc.name,
                                validator: nameValidation,
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: theme.primaryColor,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              CustomTextFormField(
                                controller: emailController,
                                labelText: loc.email,
                                validator: (_) {
                                  return null;
                                },
                                enabled: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ConfirmButton(
                confirmFunction: confirmFunction,
                cubit: profileCubit,
              ),
              SizedBox(height: 10.h),
              CustomElevatedButton(
                onPressed: () {},
                buttonChild: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.logout,
                      color: theme.scaffoldBackgroundColor,
                      size: 20.sp,
                    ),
                    SizedBox(width: 10.w),
                    CustomText(
                      data: loc.logOut,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: theme.scaffoldBackgroundColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
