import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_styles.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                // change language to english
                context.setLocale(Locale('en'));
              },
              child: context.locale.toString() == "en"
                  ? getSelectedItemWidget("english".tr())
                  : getUnSelectedItemWidget("english".tr())),
          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
              onTap: () {
                // change language to arabic
                context.setLocale(Locale('ar'));
              },
              child: context.locale.toString() == "ar"
                  ? getSelectedItemWidget("arabic".tr())
                  : getUnSelectedItemWidget("arabic".tr()))
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyles.bold20Primary,
        ),
        const Icon(
          Icons.check,
          size: 25,
          color: AppColors.primaryLight,
        )
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Text(
      text,
      style: AppStyles.bold20Black,
    );
  }
}
