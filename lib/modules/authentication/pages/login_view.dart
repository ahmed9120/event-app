import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/widgets/custom_TextFormFiled.dart';
import 'package:event_app/core/widgets/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppAssets.logo, width: 136, height: 186),
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
            CustomTextFormFiled(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ImageIcon(
                  AssetImage(AppAssets.password_icnn),
                  color: ColorPallete.textFiledBorderColor,
                ),
              ),
              hintText: "Password",
              isPassword: true,
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: ColorPallete.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationColor: ColorPallete.primaryColor,
                    decorationThickness: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            CustomButtom(
              onTap: () {},
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t Have Account ?",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color(0XFF1C1C1C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Create Account",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: ColorPallete.primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorPallete.primaryColor,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Divider(color: ColorPallete.primaryColor)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "or",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorPallete.primaryColor,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: ColorPallete.primaryColor)),
              ],
            ),
            SizedBox(height: 24),
            CustomButtom(
              onTap: () {},
              backgroundColor: ColorPallete.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.google_icn, width: 26,height: 26,),
                  SizedBox(width: 5,),
                  Text(
                    "Login With Google",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorPallete.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
