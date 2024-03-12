import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/task_model.dart';

class ListProvider extends ChangeNotifier {
  List<TaskModel> allTasks = [];

  refreshToDos() async {
    allTasks.clear();
    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(TaskModel.collectionName);
    QuerySnapshot querySnapshot =
        await todoCollection.get(); // return all data in collection
    List<QueryDocumentSnapshot<Object?>> docList = querySnapshot.docs;
    for (QueryDocumentSnapshot doc in docList) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      Timestamp dateAsTimestamp = json["date"];
      json["date"] = dateAsTimestamp.toDate();
      TaskModel task = TaskModel.fromJson(json);
      allTasks.add(task);
      print("======================================================");
      print(allTasks);
    }
    notifyListeners();
  }
}
