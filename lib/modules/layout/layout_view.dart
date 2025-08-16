import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/modules/layout/sub_modules/favorites/favorite_view.dart';
import 'package:event_app/modules/layout/sub_modules/home/home_view.dart';
import 'package:event_app/modules/layout/sub_modules/maps/maps_view.dart';
import 'package:event_app/modules/layout/sub_modules/profile/profile_view.dart';
import 'package:event_app/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

import '../../core/constants/constants.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<SettingsProvider>(context);
    var local= AppLocalizations.of(context)!;
    return Scaffold(
      body: Constants.screens[selectedIndex],
      floatingActionButton: CircleAvatar(
        backgroundColor: provider.isDark()?ColorPallete.darkThemeHomeTextColor:Colors.white,
        radius: 30,
        child: Bounceable(
          onTap: (){
            Navigator.pushNamed(context, PageRoutesName.eventCreation);
          },
          child: CircleAvatar(
            backgroundColor: provider.isDark()?ColorPallete.darkBackgroundColor:ColorPallete.primaryColor,
            radius: 25,
            child: Icon(Icons.add, color: provider.isDark()?ColorPallete.darkThemeHomeTextColor:Colors.white,size: 30,),
          ),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index){
          selectedIndex=index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(AppAssets.home_icn),
              color: provider.isDark()?ColorPallete.darkThemeHomeTextColor:Colors.white,
            ),
            activeIcon: ImageIcon(AssetImage(AppAssets.home_icn_active)),
            label: local.home,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppAssets.map_icn), color: Colors.white),
            activeIcon: ImageIcon(AssetImage(AppAssets.map_icn_active)),
            label: local.map,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(AppAssets.favorites_icn),
              color: Colors.white,
            ),
            activeIcon: ImageIcon(AssetImage(AppAssets.favorites_icn_active)),
            label: local.favorite,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(AppAssets.profile_icn),
              color: Colors.white,
            ),
            activeIcon: ImageIcon(AssetImage(AppAssets.profile_icn_active)),
            label: local.profile,
          ),
        ],
      ),
    );
  }
}
