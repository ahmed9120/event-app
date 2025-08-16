import 'package:event_app/modules/layout/sub_modules/favorites/favorite_view.dart';
import 'package:event_app/modules/layout/sub_modules/home/home_view.dart';
import 'package:event_app/modules/layout/sub_modules/maps/maps_view.dart';
import 'package:event_app/modules/layout/sub_modules/profile/profile_view.dart';
import 'package:flutter/cupertino.dart';

abstract class Constants{
  static List<Widget> screens=[
    HomeView(),
    MapsView(),
    FavoriteView(),
    ProfileView(),
  ];
}