import 'package:event_app/models/category_data.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme_manager/color_pallete.dart';

class CreateEventTabItemWidget extends StatelessWidget {
  const CreateEventTabItemWidget({
    super.key,
    required this.categoryData,
    required this.isSelected,
  });

  final CategoryData categoryData;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? ColorPallete.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorPallete.primaryColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          ImageIcon(
            AssetImage(categoryData.categoryIcn),
            size: 25,
            color: isSelected ? Colors.white : theme.primaryColor,
          ),
          SizedBox(width: 3,),
          Text(
            categoryData.categoryTitle,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: isSelected ? Colors.white : theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
