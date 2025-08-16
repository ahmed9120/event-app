import 'package:event_app/models/category_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/theme_manager/color_pallete.dart';
import '../../../../settings_provider.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({super.key, required this.categoryData, required this.isSelected});
  final CategoryData categoryData;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider= Provider.of<SettingsProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: provider.isDark()
            ? (isSelected ? theme.primaryColor : Colors.transparent)
            : (isSelected ? Colors.white : Colors.transparent),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: provider.isDark()?theme.primaryColor:ColorPallete.white,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          ImageIcon(
            AssetImage(categoryData.categoryIcn),
            size: 25,
            color: provider.isDark()
                ? (ColorPallete.darkThemeHomeTextColor)
                : (isSelected?theme.primaryColor:Colors.white),
          ),
          SizedBox(width: 3,),
          Text(
            categoryData.categoryTitle,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: provider.isDark()
                  ? (ColorPallete.darkThemeHomeTextColor)
                  : (isSelected?theme.primaryColor:Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
