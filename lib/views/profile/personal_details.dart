import 'package:batrina/controllers/cubit/profile/edit_user_cubit/edit_user_cubit.dart';
import 'package:batrina/controllers/provider/profile_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/user_model.dart';
import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';
import 'package:batrina/views/auth/widgets/custom_text_form_field.dart';
import 'package:batrina/views/profile/widgets/confirm_button.dart';
import 'package:batrina/views/profile/widgets/profile_image.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../styling/app_colors.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  late ProfileProvider profileProvider;
  late TextEditingController nameController;
  late TextEditingController emailController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? emailValidation(String? value) {
    final loc = AppLocalizations.of(context);
    if (value == null || value.trim().isEmpty) {
      return loc!.emailEmptyDescription;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return loc!.emailInvalidDescription;
    }
    return null;
  }

  String? nameValidation(String? value) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.trim().isEmpty) {
      return loc!.nameEmptyDescription;
    }
    if (value.length < 2) {
      return loc!.nameTooShortDescription;
    }
    return null;
  }

  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    nameController = TextEditingController(text: profileProvider.mainName);

    //for now we will not change email
    emailController = TextEditingController(
      text: FireBaseFireStore.currentUser!.email,
    );

    nameController.addListener(() {
      profileProvider.setName(nameController.text.trim());
    });
    super.initState();
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
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => profileCubit,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              children: [
                SizedBox(height: 25.h),
                const CustomHeaderWidget(prefix: BackArrow()),
                SizedBox(height: 45.h),
                const ProfileImage(),
                SizedBox(height: 20.h),
                CustomText(
                  data: "upload image",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 30.h),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            fontWeight: FontWeight.w500,
                            color: appColors.secondaryText,
                            fontSize: 15.sp,
                            data: 'Name',
                          ),
                          SizedBox(width: 40.w),
                          Expanded(
                            child: CustomTextFormField(
                              controller: nameController,
                              labelText: "Name",
                              validator: nameValidation,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          CustomText(
                            fontWeight: FontWeight.w500,
                            color: appColors.secondaryText,
                            fontSize: 15.sp,
                            data: 'Email',
                          ),
                          SizedBox(width: 40.w),
                          Expanded(
                            child: AbsorbPointer(
                              child: Opacity(
                                opacity: .7,
                                child: CustomTextFormField(
                                  controller: emailController,
                                  labelText: "Email",
                                  validator: emailValidation,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ConfirmButton(
                  confirmFunction: confirmFunction,
                  cubit: profileCubit,
                ),
                SizedBox(height: 5.h),
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
                        data: "log out",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
