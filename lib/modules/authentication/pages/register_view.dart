import 'package:event_app/core/utils/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/routes/page_routes_name.dart';
import '../../../core/theme_manager/color_pallete.dart';
import '../../../core/widgets/custom_TextFormFiled.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../l10n/app_localizations.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var local= AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(local.register), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AppAssets.logo, width: 136, height: 186),
                SizedBox(height: 24),
                CustomTextFormFiled(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please Enter your Name";
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ImageIcon(
                      AssetImage(AppAssets.person_icnn),
                      color: ColorPallete.textFiledBorderColor,
                    ),
                  ),
                  hintText: local.name,
                ),
                SizedBox(height: 16),
                CustomTextFormFiled(
                  controller: _emailController,
                  validator: (value) {
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ImageIcon(
                      AssetImage(AppAssets.email_icnn),
                      color: ColorPallete.textFiledBorderColor,
                    ),
                  ),
                  hintText: local.email,
                ),
                SizedBox(height: 16),
                CustomTextFormFiled(
                  controller: _passwordController,
                  validator: (value) {
                    final passwordRegex = RegExp(
                      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
                    );
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    if (!passwordRegex.hasMatch(value)) {
                      return "Please enter a valid password";
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ImageIcon(
                      AssetImage(AppAssets.password_icnn),
                      color: ColorPallete.textFiledBorderColor,
                    ),
                  ),
                  hintText: local.password,
                  isPassword: true,
                ),
                SizedBox(height: 16),
                CustomTextFormFiled(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password didn't match";
                    }
                    if (value != _passwordController.text) {
                      return "Password didn't match";
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ImageIcon(
                      AssetImage(AppAssets.password_icnn),
                      color: ColorPallete.textFiledBorderColor,
                    ),
                  ),
                  hintText: local.repassword,
                  isPassword: true,
                ),
                SizedBox(height: 16),
                CustomButtom(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show();
                      FireBaseAuthentication.createUserWithEmailAndPassword(
                        userFullName: _nameController.text,
                        emailAddress: _emailController.text,
                        password: _passwordController.text,
                      ).then((value) {
                        EasyLoading.dismiss();
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(
                    local.createAccount,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      local.alreadyHaveAcc,
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
                        local.login,
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
      ),
    );
  }
}
