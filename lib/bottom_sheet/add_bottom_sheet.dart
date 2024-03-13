import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/extention_function/extention_function_l10n.dart';
import 'package:to_do_list/model/task_model.dart';
import 'package:to_do_list/providers/list_provider.dart';
import 'package:to_do_list/utilities/app_theme.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.l10n.add_new_task,
              style: AppTheme.bottomSheetTextStyle,
              textAlign: TextAlign.center),
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: context.l10n.title),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: context.l10n.description,
            ),
          ),
          Text(context.l10n.select_time),
          const SizedBox(
            height: 12,
          ),
          InkWell(
              onTap: () {
                showMyDatePicker();
              },
              child: Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                textAlign: TextAlign.center,
                style: AppTheme.taskDescriptionTextStyle,
              )),
          const Spacer(),
          //add button
          ElevatedButton(
              onPressed: () {
                TaskModel task = TaskModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    date: selectedDate);
                addToDoToFirebase(task);
                //FirebaseFunctions.addTask(task);
                //listProvider.refreshToDos();
                Navigator.pop(context);
              },
              child: Text(context.l10n.add))
        ],
      ),
    );
  }

  void showMyDatePicker() async {
    selectedDate = (await showDatePicker(
            context: context,
            initialDate: selectedDate,
            //this date that appears when open the calender
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selectedDate);
    setState(() {});
  }

  //add data to firestore
  void addToDoToFirebase(TaskModel task) {
    CollectionReference toDoCollection =
        FirebaseFirestore.instance.collection(TaskModel.collectionName);
    var docRef = toDoCollection.doc();
    task.id = docRef.id;
    docRef.set(task.toJson());
    listProvider.refreshToDos();
  }
}
