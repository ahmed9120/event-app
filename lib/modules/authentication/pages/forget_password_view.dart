import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/utils/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/theme_manager/color_pallete.dart';
import '../../../core/widgets/custom_TextFormFiled.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../l10n/app_localizations.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _emailController= TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var local= AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(local.forgetPassword),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.forget_password_img, height: MediaQuery.of(context).size.width* 0.8,),
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
              CustomButtom(
                onTap: () {
                  if(_formKey.currentState!.validate()){
                    EasyLoading.show();
                    FireBaseAuthentication.resetPassword(email: _emailController.text).then((success){
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                    });
                  }
                },
                child: Text(
                  local.resetPassword,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
