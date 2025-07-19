import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/routes/page_routes_name.dart';
import '../../../core/theme_manager/color_pallete.dart';
import '../../../core/widgets/custom_TextFormFiled.dart';
import '../../../core/widgets/custom_buttom.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.logo, width: 136, height: 186),
              SizedBox(height: 24),
              CustomTextFormFiled(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(
                    AssetImage(AppAssets.person_icnn),
                    color: ColorPallete.textFiledBorderColor,
                  ),
                ),
                hintText: "Name",
              ),
              SizedBox(height: 16),
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
              CustomTextFormFiled(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(
                    AssetImage(AppAssets.password_icnn),
                    color: ColorPallete.textFiledBorderColor,
                  ),
                ),
                hintText: "Re Password",
                isPassword: true,
              ),
              SizedBox(height: 16),
              CustomButtom(
                onTap: () {},
                child: Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have Account ?",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Color(0XFF1C1C1C),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: "Inter",
                          color: ColorPallete.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          decorationThickness: 2,
                        ),
          
                    ),
                  ),
                ],
              ),
          
          
            ],
          ),
        ),
      ),
    );
  }
}
