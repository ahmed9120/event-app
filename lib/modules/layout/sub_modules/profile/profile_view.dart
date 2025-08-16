import 'dart:developer';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/widgets/custom_buttom.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/firebase_authentication.dart';
import '../../../settings_provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? selectedProfileImage;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        selectedProfileImage = File(pickedFile.path);
      });
    }
  }

  List<String> languageList = ["English", "عربي"];
  List<String> themeList = ["Light", "Dark"];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var localization = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingsProvider>(context);
    var local= AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                provider.currentLanguage == "en" ? 64 : 0,
              ),
              bottomRight: Radius.circular(
                provider.currentLanguage == "en" ? 0 : 64,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 64,
              left: 16,
              right: 16,
              bottom: 32,
            ),
            child: Row(
              children: [
                Bounceable(
                  onTap: pickImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: provider.currentLanguage == "en"
                          ? Radius.circular(24)
                          : Radius.circular(1000),
                      topRight: provider.currentLanguage == "en"
                          ? Radius.circular(1000)
                          : Radius.circular(24),
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000),
                    ),
                    child: selectedProfileImage == null
                        ? Image.asset(
                            AppAssets.default_profile_img,
                            width: 124,
                            height: 124,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            selectedProfileImage!,
                            width: 124,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.userFullName ?? "User Name",
                        style: theme.textTheme.headlineSmall,
                      ),
                      Text(
                        provider.userEmailAddress?? "User Name",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: ColorPallete.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Text(
                      localization.language,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: provider.isDark()
                            ? ColorPallete.white
                            : Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CustomDropdown<String>(
                      hintText: 'Select language',
                      items: languageList,
                      initialItem: provider.currentLanguage == "en"
                          ? "English"
                          : "عربي",
                      decoration: CustomDropdownDecoration(
                        closedFillColor: Colors.transparent,
                        closedBorder: Border.all(
                          color: theme.primaryColor,
                          width: 2,
                        ),
                        closedSuffixIcon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: theme.primaryColor,
                          size: 30,
                        ),
                        headerStyle: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      onChanged: (value) {
                        log('changing value to: $value');
                        provider.changeLanguage(value == "English" ? "en" : "ar");
                      },
                    ),
                    Text(
                      localization.theme_mode,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: provider.isDark()
                            ? ColorPallete.white
                            : Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CustomDropdown<String>(
                      hintText: 'Select theme',
                      items: themeList,
                      initialItem: provider.isDark() ? "Dark" : "Light",
                      decoration: CustomDropdownDecoration(
                        closedFillColor: Colors.transparent,
                        closedBorder: Border.all(
                          color: theme.primaryColor,
                          width: 2,
                        ),
                        closedSuffixIcon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: theme.primaryColor,
                          size: 30,
                        ),
                        headerStyle: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onChanged: (value) {
                        log('changing value to: $value');
                        provider.changeTheme(
                          value == "Dark" ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: CustomButtom(
                    onTap: (){
                      provider.resetUserNameAndEmailAndUid();
                      FireBaseAuthentication.logout(context);
                    },
                    backgroundColor: ColorPallete.deleteRedColor,
                    borderColor: ColorPallete.deleteRedColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:8,horizontal: 16),
                      child: Row(
                        //mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(Icons.logout_rounded, color: Colors.white, size: 30,),
                          SizedBox(width: 10,),
                          Text(local.logout, style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
