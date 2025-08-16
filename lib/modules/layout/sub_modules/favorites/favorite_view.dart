import 'package:event_app/core/widgets/custom_TextFormFiled.dart';
import 'package:event_app/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/firebase_firestore.dart';
import '../../../../models/event_task_data.dart';
import '../home/widgets/event_item_widget.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  List<EventTaskData> allEventsTaskList = [];
  List<EventTaskData> filteredEventsList = [];
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider= Provider.of<SettingsProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextFormFiled(
              onChanged: (value) {
                searchText = value.toLowerCase();
                filteredEventsList = allEventsTaskList.where((e) {
                  return e.eventTitle.toLowerCase().contains(searchText);
                }).toList();
                setState(() {});
              },
              hintText: "Search for Event",
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: theme.primaryColor,
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestoreUtils.getFavoriteStreamEventTaskList(uid: provider.userUid??"0"),
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
              allEventsTaskList = snapshot.data!.docs
                  .map((e) => e.data())
                  .toList();
              filteredEventsList = searchText.isEmpty
                  ? allEventsTaskList
                  : allEventsTaskList.where((e) {
                      return e.eventTitle.toLowerCase().contains(searchText.toLowerCase());
                    }).toList();
              return Expanded(
                child: filteredEventsList.isEmpty
                    ? Center(
                        child: Text(
                          "You Don't Have Favorite Events",
                          style: theme.textTheme.titleLarge,
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return EventItemWidget(
                            eventTaskData: filteredEventsList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 18);
                        },
                        itemCount: filteredEventsList.length,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
