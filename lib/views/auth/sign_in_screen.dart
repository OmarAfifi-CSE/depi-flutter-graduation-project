import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 73.h),
            //temp
            Image.network(""),
            SizedBox(height: 69.h),
            Text("Welcome", style: theme.textTheme.titleLarge),
            SizedBox(height: 14.h),
            Text("Welcome", style: theme.textTheme.titleLarge),
            SizedBox(height: 68.h),
          ],
        ),
      ),
    );
  }
}
