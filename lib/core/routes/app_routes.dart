import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/modules/authentication/pages/forget_password_view.dart';
import 'package:event_app/modules/authentication/pages/login_view.dart';
import 'package:event_app/modules/splash/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../modules/authentication/pages/register_view.dart';

abstract class AppRoutes{

  static Route<dynamic> onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case PageRoutesName.initial:
        return MaterialPageRoute(builder: (_)=> const SplashView(), settings: settings);
      case PageRoutesName.login:
        return MaterialPageRoute(builder: (_)=> const LoginView(), settings: settings);
      case PageRoutesName.register:
        return MaterialPageRoute(builder: (_)=> const RegisterView(), settings: settings);
      case PageRoutesName.forgetPassword:
        return MaterialPageRoute(builder: (_)=> const ForgetPasswordView(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_)=> const SplashView(), settings: settings);

    }
  }
}