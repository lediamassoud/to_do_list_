import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/my_user.dart';
import '../model/task_model.dart';

class ListProvider extends ChangeNotifier {
  List<TaskModel> allTasks = [];

  DateTime selectedDate = DateTime.now();

  onSelectedDateChanged(DateTime newDateTime) {
    selectedDate = newDateTime;
    refreshToDos();
    notifyListeners();
  }

  refreshToDos() async {
    allTasks.clear();
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(MyUser.currentUser!.id)
        .collection(TaskModel.collectionName);
    QuerySnapshot querySnapshot = await todoCollection
        .orderBy("date")
        .get(); // return all data in collection
    List<QueryDocumentSnapshot<Object?>> docList = querySnapshot.docs;
    for (QueryDocumentSnapshot doc in docList) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      Timestamp dateAsTimestamp = json["date"];
      json["date"] = dateAsTimestamp.toDate();
      TaskModel task = TaskModel.fromJson(json);

      if (task.date!.year == selectedDate.year &&
          task.date!.month == selectedDate.month &&
          task.date!.day == selectedDate.day) {
        allTasks.add(task);
      }
    }
    notifyListeners();
  }

  void clear() {
    allTasks = [];
    selectedDate = DateTime.now();
    MyUser.currentUser = null;
  }
}
