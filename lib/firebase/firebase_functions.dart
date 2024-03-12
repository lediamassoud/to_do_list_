import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/model/task_model.dart';

class FirebaseFunctions {
  static List<TaskModel> allTasks = [];

  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static void addTask(TaskModel taskModel) {
    var taskCollection = getTaskCollection();
    var docRef = taskCollection.doc(); //to make id auto generate
    taskModel.id = docRef.id;
    docRef.set(taskModel); //add task model in firebase firestore
    //taskCollection.add(taskModel);
    allTasks.add(taskModel);
  }
}
