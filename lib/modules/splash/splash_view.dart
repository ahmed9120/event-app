import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1),(){
      Navigator.pushReplacementNamed(context, PageRoutesName.login);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Image.asset(AppAssets.logo, width: 136, height: 187,)),
          Positioned(left: MediaQuery.of(context).size.width/4.5,bottom: 15,child: Image.asset(AppAssets.splash_bottom_img, width: 214, height: 86,)),
        ],
      ),
    );
  }
}
