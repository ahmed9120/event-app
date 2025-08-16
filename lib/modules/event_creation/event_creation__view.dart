import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/utils/firebase_firestore.dart';
import 'package:event_app/core/widgets/custom_buttom.dart';
import 'package:event_app/models/event_task_data.dart';
import 'package:event_app/modules/event_creation/widgets/create_event_tab_item_widget.dart';
import 'package:event_app/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/services/snackbar_services.dart';
import '../../core/widgets/custom_TextFormFiled.dart';
import '../../models/category_data.dart';

class EventCreationView extends StatefulWidget {
  const EventCreationView({super.key});

  @override
  State<EventCreationView> createState() => _EventCreationViewState();
}

class _EventCreationViewState extends State<EventCreationView> {
  int currentTabIndex = 0;
  DateTime? selectedDate;
  String? selectedTime;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<CategoryData> categories = [
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
    final eventTaskDataDetails =ModalRoute.of(context)!.settings.arguments;
    if (eventTaskDataDetails != null && eventTaskDataDetails is EventTaskData){
      selectedDate=eventTaskDataDetails.selectedDate;
      selectedTime=eventTaskDataDetails.selectedTime;
      titleController.text= eventTaskDataDetails.eventTitle;
      descriptionController.text=eventTaskDataDetails.eventDescription;
    }


    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomButtom(
            onTap: () {
              if (formKey.currentState!.validate()) {
                if (selectedDate != null && selectedTime != null) {
                  var eventData = EventTaskData(
                    eventCategory: categories[currentTabIndex].categoryTitle,
                    eventCategoryImg: categories[currentTabIndex].categoryImage,
                    eventTitle: titleController.text,
                    eventDescription: descriptionController.text,
                    selectedDate: selectedDate!,
                    selectedTime: selectedTime!,
                    lat: provider.eventLocation==null?0: provider.eventLocation!.latitude.toDouble(),
                    long: provider.eventLocation==null?0: provider.eventLocation!.longitude.toDouble(),
                    userUid: provider.userUid??"0",
                  );
                  EasyLoading.show();

                  FirebaseFirestoreUtils.createNewEventTask(eventData).then((
                    value,
                  ) {
                    Future.delayed(Duration(seconds: 1), () {
                      EasyLoading.showSuccess(
                        "Done",
                        duration: Duration(milliseconds: 500),
                      );
                      EasyLoading.dismiss();
                      if (value) {
                        provider.textAddressLocation="Choose Location";
                        provider.eventLocation=null;
                        Navigator.pop(context);
                        SnackbarServices.showSuccessMessage(
                          "Event has been created succesuflly",
                        );
                      } else {
                        SnackbarServices.showErrorMessage(
                          "Something went wrong",
                        );
                      }
                    });
                  });
                }
              }
            },
            child: Text(
              "Add Event",
              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(
          "Create Event",
          style: theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    categories[currentTabIndex].categoryImage,
                    height: 203,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
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
                      return CreateEventTabItemWidget(
                        isSelected:
                            currentTabIndex == categories.indexOf(categoryData),
                        categoryData: categoryData,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Title",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: ColorPallete.generalTextColor,
                  ),
                ),
                SizedBox(height: 5),
                CustomTextFormFiled(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter a valid title";
                    }
                    return null;
                  },
                  prefixIcon: Icon(
                    Icons.edit_calendar,
                    color: ColorPallete.textFiledBorderColor,
                  ),
                  hintText: "Event Title",
                ),
                SizedBox(height: 16),
                Text(
                  "Description",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: ColorPallete.generalTextColor,
                  ),
                ),
                SizedBox(height: 5),
                CustomTextFormFiled(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter a valid description";
                    }
                    return null;
                  },
                  maxLines: 4,
                  hintText: "Event Description",
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.calendar_month),
                    SizedBox(width: 10),
                    Text("Event Date", style: theme.textTheme.bodyMedium),
                    Spacer(),
                    Bounceable(
                      onTap: () {
                        getCurrentDate();
                      },
                      child: Text(
                        selectedDate != null
                            ? DateFormat("d MMM yyyy").format(selectedDate!)
                            : "Choose Date",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined),
                    SizedBox(width: 10),
                    Text("Event Time", style: theme.textTheme.bodyMedium),
                    Spacer(),
                    Bounceable(
                      onTap: () {
                        getCurrentTime();
                      },
                      child: Text(
                        selectedTime != null ? selectedTime! : "Choose Time",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Location",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: ColorPallete.generalTextColor,
                  ),
                ),
                SizedBox(height: 5),
                CustomButtom(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(PageRoutesName.pickEventMapScreen);
                  },
                  backgroundColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.my_location,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          provider.textAddressLocation,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.primaryColor,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: theme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 130),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getCurrentDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((value) {
      selectedDate = value;
      setState(() {});
    });
  }

  getCurrentTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((
      value,
    ) {
      selectedTime = value!.format(context);
      setState(() {});
    });
  }
}
