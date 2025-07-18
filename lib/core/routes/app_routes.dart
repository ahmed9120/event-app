import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/modules/authentication/pages/login_view.dart';
import 'package:event_app/modules/splash/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes{

  static Route<dynamic> onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case PageRoutesName.initial:
        return MaterialPageRoute(builder: (_)=> const SplashView(), settings: settings);
      case PageRoutesName.login:
        return MaterialPageRoute(builder: (_)=> const LoginView(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_)=> const SplashView(), settings: settings);

    }
  }
}