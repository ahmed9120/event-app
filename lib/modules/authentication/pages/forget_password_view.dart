import 'package:event_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../core/theme_manager/color_pallete.dart';
import '../../../core/widgets/custom_TextFormFiled.dart';
import '../../../core/widgets/custom_buttom.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppAssets.forget_password_img, height: MediaQuery.of(context).size.width* 0.8,),
            SizedBox(height: 24),
            CustomTextFormFiled(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ImageIcon(
                  AssetImage(AppAssets.email_icnn),
                  color: ColorPallete.textFiledBorderColor,
                ),
              ),
              hintText: "Email",
            ),
            SizedBox(height: 16),
            CustomButtom(
              onTap: () {},
              child: Text(
                "Reset Password",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
