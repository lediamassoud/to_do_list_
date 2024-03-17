import 'package:flutter/material.dart';
import 'package:to_do_list/extention_function/extention_function_l10n.dart';

import '../model/task_model.dart';
import '../utilities/app_theme.dart';

class EditTask extends StatelessWidget {
  static const routeName = "edite_page";

  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  EditTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.app_title),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: AppTheme.primaryBlue,
                    width: double.infinity,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            color: AppTheme.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(context.l10n.edit_task,
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
                      // showMyDatePicker();
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
                      // addToDoToFirebase(task);
                      //FirebaseFunctions.addTask(task);
                      //listProvider.refreshToDos();
                      Navigator.pop(context);
                    },
                    child: Text(context.l10n.save_changes))
              ],
            ),
          )
        ],
      ),
    );
  }
}
