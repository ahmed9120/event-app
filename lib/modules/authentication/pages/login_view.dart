import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/utils/firebase_authentication.dart';
import 'package:event_app/core/widgets/custom_TextFormFiled.dart';
import 'package:event_app/core/widgets/custom_buttom.dart';
import 'package:event_app/modules/settings_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<SettingsProvider>(context);
    var local= AppLocalizations.of(context)!;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                Image.asset(AppAssets.logo, width: 136, height: 186),
                SizedBox(height: 24),
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
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        PageRoutesName.forgetPassword,
                      );
                    },
                    child: Text(
                      local.forgetPassword,
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
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show();
                      FireBaseAuthentication.signInWithEmailAndPassword(
                        emailAddress: _emailController.text,
                        password: _passwordController.text,
                      ).then((success){
                        EasyLoading.dismiss();
                        if(success){
                          final user= FirebaseAuth.instance.currentUser;
                          provider.setUserNameAndEmailAndUid(name:user?.displayName??"User Name",email: user?.email??"email@domain.com",uid: user?.uid??"0");
                          Navigator.pushNamed(context, PageRoutesName.layout);
                        }

                      });
                    }
                  },
                  child: Text(
                    local.login,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      local.dontHaveAcc,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0XFF1C1C1C),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PageRoutesName.register);
                      },
                      child: Text(
                        local.createAccount,
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
                        local.or,
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
                  onTap: () {
                    FireBaseAuthentication.signInWithGoogle().then((success){
                      final user= FirebaseAuth.instance.currentUser;
                      if(success){
                        provider.setUserNameAndEmailAndUid(name:user?.displayName??"User Name",email: user?.email??"email@domain.com",uid: user?.uid??"0");
                        Navigator.pushNamed(context, PageRoutesName.layout);
                      }
                    });
                  },
                  backgroundColor: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.google_icn, width: 26, height: 26),
                      SizedBox(width: 5),
                      Text(
                        local.loginWithGoogle,
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
        ),
      ),
    );
  }
}
