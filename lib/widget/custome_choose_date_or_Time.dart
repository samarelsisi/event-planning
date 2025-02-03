import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme_provider.dart';
import '../style/app_styles.dart';
class ChooseDateOrTime extends StatelessWidget {
  String iconName;
  String eventDateOrTime;
  String chooseDateOrTime;
  Function onChooseDateOrTime;
  ChooseDateOrTime(
      {required this.iconName,
      required this.eventDateOrTime,
      required this.chooseDateOrTime,
      required this.onChooseDateOrTime});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(iconName),
        SizedBox(
          width: width * 0.02,
        ),
        Expanded(
          child: Text(
            eventDateOrTime,
            style: themeProvider.appTheme == ThemeMode.light
                ? AppStyles.medium16Primary
                : AppStyles.medium16White,
          ),
        ),
        TextButton(
          onPressed: () {
            onChooseDateOrTime();
          },
          child: Text(
            chooseDateOrTime,
            style: AppStyles.medium16Primary,
          ),
        )
      ],
    );
  }
}
