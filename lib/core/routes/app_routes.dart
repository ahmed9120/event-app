import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/modules/authentication/pages/forget_password_view.dart';
import 'package:event_app/modules/authentication/pages/login_view.dart';
import 'package:event_app/modules/event_creation/event_creation__view.dart';
import 'package:event_app/modules/layout/layout_view.dart';
import 'package:event_app/modules/splash/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../modules/authentication/pages/register_view.dart';
import '../../modules/event_creation/pick_event_map_screen.dart';
import '../../modules/event_details/event_details_view.dart';

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
      case PageRoutesName.layout:
        return MaterialPageRoute(builder: (_)=> const LayoutView(), settings: settings);
      case PageRoutesName.eventCreation:
        return MaterialPageRoute(builder: (_)=> const EventCreationView(), settings: settings);
      case PageRoutesName.pickEventMapScreen:
        return MaterialPageRoute(builder: (_)=> const PickEventMapScreen(), settings: settings);
      case PageRoutesName.eventDetails:
        return MaterialPageRoute(builder: (_)=> const EventDetailsView(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_)=> const SplashView(), settings: settings);

    }
  }
}