import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/models/category_data.dart';
import 'package:event_app/modules/layout/sub_modules/home/widgets/event_item_widget.dart';
import 'package:event_app/modules/layout/sub_modules/home/widgets/tab_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/local_storage_keys.dart';
import '../../../../core/services/local_storage_services.dart';
import '../../../../core/utils/firebase_firestore.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/event_task_data.dart';
import '../../../settings_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int currentTabIndex = 0;
  List<CategoryData> categories = [
    CategoryData(
      id: "All",
      categoryTitle: "All",
      categoryImage: "",
      categoryIcn: AppAssets.all_icn,
    ),
    CategoryData(
      id: "Book Clubs",
      categoryTitle: "Book Clubs",
      categoryImage: AppAssets.bookclub_img,
      categoryIcn: AppAssets.book_icn,
    ),
    CategoryData(
      id: "Sports",
      categoryTitle: "Sports",
      categoryImage: AppAssets.sport_img,
      categoryIcn: AppAssets.sport_icn,
    ),
    CategoryData(
      id: "BirthDay",
      categoryTitle: "BirthDay",
      categoryImage: AppAssets.birthday_img,
      categoryIcn: AppAssets.birthday_icn,
    ),
    CategoryData(
      id: "Meetings",
      categoryTitle: "Meetings",
      categoryImage: AppAssets.meeting_img,
      categoryIcn: AppAssets.sport_icn,
    ),
    CategoryData(
      id: "Gaming",
      categoryTitle: "Gaming",
      categoryImage: AppAssets.gaming_img,
      categoryIcn: AppAssets.sport_icn,
    ),
    CategoryData(
      id: "WorkShop",
      categoryTitle: "WorkShop",
      categoryImage: AppAssets.workshop_img,
      categoryIcn: AppAssets.sport_icn,
    ),
  ];



  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider= Provider.of<SettingsProvider>(context);
    var local= AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 40),
            decoration: BoxDecoration(
              color: provider.isDark()?ColorPallete.darkBackgroundColor:theme.primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          local.welcomeBack,
                          style: provider.isDark()?theme.textTheme.bodySmall!.copyWith(color: ColorPallete.darkThemeHomeTextColor):theme.textTheme.bodySmall,
                        ),
                        Text(
                          provider.userFullName??"User Name",
                          style: provider.isDark()?theme.textTheme.headlineSmall!.copyWith(color: ColorPallete.darkThemeHomeTextColor):theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        Bounceable(
                          onTap: () {
                            provider.changeTheme(provider.isDark()?ThemeMode.light:ThemeMode.dark);
                          },
                          child: Icon(
                            provider.isDark()?Icons.dark_mode_outlined:Icons.wb_sunny_outlined,
                            color: provider.isDark()?ColorPallete.darkThemeHomeTextColor:ColorPallete.white,
                            size: 30,
                          ),
                        ),
                        Bounceable(
                          onTap: () {
                            provider.changeLanguage(provider.currentLanguage=="en"?"ar":"en");
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: provider.isDark()?ColorPallete.darkThemeHomeTextColor:ColorPallete.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              provider.currentLanguage=="en"?"EN":"AR",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: provider.isDark()?ColorPallete.darkBackgroundColor:ColorPallete.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    ImageIcon(
                      AssetImage(AppAssets.map_icn),
                      color: provider.isDark()?ColorPallete.darkThemeHomeTextColor:ColorPallete.white,
                    ),
                    Text("Cairo , Egypt", style: provider.isDark()?theme.textTheme.bodySmall!.copyWith(color: ColorPallete.darkThemeHomeTextColor):theme.textTheme.bodySmall),
                  ],
                ),
                DefaultTabController(
                  length: categories.length,
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        currentTabIndex = index;
                      });
                    },
                    isScrollable: true,
                    indicator: BoxDecoration(),
                    indicatorColor: Colors.transparent,
                    indicatorWeight: 0,
                    labelPadding: EdgeInsets.symmetric(horizontal: 4),
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    tabs: categories.map((categoryData) {
                      return TabItemWidget(
                        isSelected:
                            currentTabIndex == categories.indexOf(categoryData),
                        categoryData: categoryData,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          StreamBuilder(
            stream: FirebaseFirestoreUtils.getStreamEventTaskList(categoryID: categories[currentTabIndex].id, uid: provider.userUid??"0"),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: theme.textTheme.titleLarge,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              List<EventTaskData> eventTaskData =
                  snapshot.data!.docs.map((e) => e.data()).toList() ?? [];
              return Expanded(
                child: eventTaskData.isEmpty
                    ? Center(
                        child: Text(
                          "You Don't Have Current Events",
                          style: theme.textTheme.titleLarge,
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return Bounceable(
                            onTap: ()async{
                              String eventTextLocation= await provider.getAddressFromLatLng(eventTaskData[index].lat, eventTaskData[index].long)??"no location";
                              Navigator.pushNamed(context, PageRoutesName.eventDetails, arguments: {
                                "eventDetails" : eventTaskData[index],
                                "eventTextLocation" : eventTextLocation
                              },);
                            },
                            child: EventItemWidget(
                              eventTaskData: eventTaskData[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 18);
                        },
                        itemCount: eventTaskData.length,
                      ),
              );
            },
          ),

          // FutureBuilder<List<EventTaskData>>(
          //     future: FirebaseFirestoreUtils.getEventTaskList(),
          //     builder:(context, snapshot){
          //       if(snapshot.hasError){
          //         return Center(child: Text(snapshot.error.toString(), style: theme.textTheme.titleLarge,),);
          //       }
          //       if(snapshot.connectionState==ConnectionState.waiting){
          //         return Center(child: CircularProgressIndicator(),);
          //       }
          //       List<EventTaskData> eventTaskData= snapshot.data??[];
          //       return Expanded(
          //         child: ListView.separated(
          //           itemBuilder: (context, index) {
          //             return EventItemWidget(eventTaskData: eventTaskData[index],);
          //           },
          //           separatorBuilder: (context, index) {
          //             return SizedBox(height: 18);
          //           },
          //           itemCount: eventTaskData.length,
          //         ),
          //       );
          //     },
          // ),
        ],
      ),
    );
  }
}
