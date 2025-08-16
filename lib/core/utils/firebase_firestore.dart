import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/models/event_task_data.dart';

abstract class FirebaseFirestoreUtils {


  static CollectionReference<EventTaskData> _getCollectionReference() {
    return FirebaseFirestore.instance
        .collection(EventTaskData.collectionName)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              EventTaskData.fromFirestore(snapshot.data()!),
          toFirestore: (value, _) => value.toFirestore(),
        );
  }

  static Future<bool> createNewEventTask(EventTaskData eventTaskData){
    try{
      var collectionReference= _getCollectionReference();
      var documentReference= collectionReference.doc();
      eventTaskData.eventID= documentReference.id; //document id auto generated
      documentReference.set(eventTaskData);
      return Future.value(true);
    }catch(e){
      return Future.value(false);
    }

  }

  static Future<List<EventTaskData>> getEventTaskList({required String uid}) async{
    var collectionReference= _getCollectionReference().where("userUid", isEqualTo: uid);
    var dataCollection= await collectionReference.get();
    return dataCollection.docs.map((e)=>e.data()).toList();
  }

  static Stream<QuerySnapshot<EventTaskData>> getStreamEventTaskList({required String categoryID, required String uid}) {
    if(categoryID=="All"){
      var collectionReference= _getCollectionReference().where("userUid", isEqualTo: uid);
      return collectionReference.snapshots();
    }else{
      var collectionReference= _getCollectionReference().where("userUid", isEqualTo: uid).where("eventCategory", isEqualTo: categoryID);
      return collectionReference.snapshots();
    }
  }

  static Stream<QuerySnapshot<EventTaskData>> getFavoriteStreamEventTaskList({required String uid}) {
      var collectionReference= _getCollectionReference().where("userUid", isEqualTo: uid).where("isFavourite", isEqualTo: true);
      return collectionReference.snapshots();
  }

  static Future<void> updateEventTask({required EventTaskData eventTaskData}){
      var collectionReference= _getCollectionReference();
      var documentReference= collectionReference.doc(eventTaskData.eventID);
      return documentReference.set(eventTaskData);
  }

  static Future<void> deleteEventTask({required EventTaskData eventTaskData}){
    var collectionReference= _getCollectionReference();
    var documentReference= collectionReference.doc(eventTaskData.eventID);
    return documentReference.delete();
  }
}
