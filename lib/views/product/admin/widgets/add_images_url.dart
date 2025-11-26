import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/product/admin/widgets/add_image_text_field.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddImagesUrl extends StatefulWidget {
  const AddImagesUrl({super.key, required this.images, required this.refresh});
  final List<String> images;
  final void Function() refresh;

  @override
  State<AddImagesUrl> createState() => _AddImagesUrlState();
}

class _AddImagesUrlState extends State<AddImagesUrl> {
  List<TextEditingController> formsControllers = [TextEditingController()];
  GlobalKey<FormState> _formKey = GlobalKey();
  void addAnotherForm() {
    setState(() {
      formsControllers.add(TextEditingController());
    });
  }

  void removeForm(int index) {
    setState(() {
      formsControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.all(12.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              data: loc!.pasteImagesUrl,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20.h),
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(formsControllers.length, (index) {
                    return AddImageTextField(
                      controller: formsControllers[index],
                      AddAnotherField: index == formsControllers.length - 1
                          ? (formsControllers.length != 5
                                ? addAnotherForm
                                : null)
                          : null,
                      removeField: formsControllers.length != 1
                          ? removeForm
                          : null,
                      index: index,
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  buttonChild: CustomText(
                    data: loc.cancel,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: theme.primaryColor,
                  ),
                  backgroundColor: theme.scaffoldBackgroundColor,
                  extend: true,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      for (var form in formsControllers) {
                        if (!widget.images.contains(form.text.trim())) {
                          widget.images.add(form.text.trim());
                        }
                      }
                      widget.refresh();
                      Navigator.pop(context);
                    }
                  },
                  buttonChild: CustomText(
                    data: loc.save,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: theme.scaffoldBackgroundColor,
                  ),
                  backgroundColor: theme.primaryColor,
                  extend: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
