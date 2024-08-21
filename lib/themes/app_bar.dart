import 'package:flutter/material.dart';

import 'package:task_manager_with_getx/utils/app_color.dart';

AppBarTheme getAppBarTheme() => const AppBarTheme(
      backgroundColor: AppColor.themeColor,
      foregroundColor: AppColor.white,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500
      ),
    );
