import 'package:batrina/controllers/provider/locale_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/utils/language_helper.dart';
import 'package:batrina/views/categories/widgets/search_bar.dart';
import 'package:batrina/views/profile/language_selection/widgets/language_card.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final currentLocale = localeProvider.locale;
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    const allLocales = AppLocalizations.supportedLocales;
    final filteredLocales = allLocales.where((locale) {
      final native = LanguageHelper.getNativeName(
        locale.languageCode,
      ).toLowerCase();
      final english = LanguageHelper.getEnglishName(
        locale.languageCode,
      ).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return native.contains(query) || english.contains(query);
    }).toList();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomHeaderWidget(
            center: CustomText(
              data: loc!.language,
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
              SizedBox(height: 20.h),
              SearchBarWidget(
                onChanged: (text) {
                  setState(() {
                    _searchQuery = text;
                  });
                },
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: filteredLocales.isEmpty
                    ? _buildEmptyState(theme, appColors)
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.w,
                          vertical: 16.h,
                        ),
                        itemCount: filteredLocales.length,
                        separatorBuilder: (c, i) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final locale = filteredLocales[index];
                          final isSelected =
                              locale.languageCode == currentLocale.languageCode;
                          return LanguageCard(
                            locale: locale,
                            isSelected: isSelected,
                            onTap: () {
                              context.read<LocaleProvider>().setLocale(
                                locale.languageCode,
                              );
                              Future.delayed(
                                const Duration(milliseconds: 400),
                                () {
                                  if (context.mounted) context.pop();
                                },
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, AppColorTheme appColors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.language, size: 60.sp, color: appColors.dividerColor),
          SizedBox(height: 16.h),
          CustomText(
            data: "No language found",
            fontSize: 16.sp,
            color: theme.primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
