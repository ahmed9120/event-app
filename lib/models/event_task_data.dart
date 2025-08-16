
class EventTaskData {
  static const String collectionName="event_tasks";

  String? eventID;
  String eventCategory;
  String eventCategoryImg;
  String eventTitle;
  String eventDescription;
  DateTime selectedDate;
  String selectedTime;
  bool isFavourite;
  double lat;
  double long;
  String userUid;

  EventTaskData({

    this.eventID,
    required this.eventCategory,
    required this.eventCategoryImg,
    required this.eventTitle,
    required this.eventDescription,
    required this.selectedDate,
    required this.selectedTime,
    this.isFavourite=false,
    required this.lat,
    required this.long,
    required this.userUid
  });

  Map<String, dynamic> toFirestore() {
    return {
      'eventID': this.eventID,
      'eventCategory': this.eventCategory,
      'eventCategoryImg': this.eventCategoryImg,
      'eventTitle': this.eventTitle,
      'eventDescription': this.eventDescription,
      'selectedDate': this.selectedDate.millisecondsSinceEpoch,
      'selectedTime': this.selectedTime,
      'isFavourite': this.isFavourite,
      'lat': this.lat,
      'long': this.long,
      "userUid": this.userUid
    };
  }

  factory EventTaskData.fromFirestore(Map<String, dynamic> map) {
    return EventTaskData(
      eventID: map['eventID'],
      eventCategory: map['eventCategory'],
      eventCategoryImg: map['eventCategoryImg'],
      eventTitle: map['eventTitle'],
      eventDescription: map['eventDescription'],
      selectedDate: DateTime.fromMillisecondsSinceEpoch(map['selectedDate']),
      selectedTime: map['selectedTime'],
      isFavourite: map['isFavourite'],
      lat: map['lat'] as double,
      long: map['long'] as double,
      userUid:map['userUid'],

    );
  }



}
