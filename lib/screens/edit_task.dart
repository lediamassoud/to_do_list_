import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/extention_function/extention_function_l10n.dart';
import 'package:to_do_list/providers/theme_provider.dart';

import '../model/my_user.dart';
import '../model/task_model.dart';
import '../providers/list_provider.dart';
import '../utilities/app_theme.dart';

class EditTask extends StatefulWidget {
  static const routeName = "edite_page";

  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  DateTime selectedDate = DateTime.now();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  late ListProvider listProvider;
  late ThemeProvider themeProvider;
  late TaskModel editTask;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    editTask = ModalRoute.of(context)!.settings.arguments as TaskModel;
    titleController.text = editTask.title!;
    descriptionController.text = editTask.description!;
    selectedDate = editTask.date!;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.app_title),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            color: themeProvider.isDark
                ? AppTheme.primaryDark
                : AppTheme.primaryLight,
            width: double.infinity,
          ),
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
            color: themeProvider.isDark
                ? AppTheme.secondaryBlue
                : AppTheme.primaryLight,
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
                      showMyDatePicker();
                    },
                    child: Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      textAlign: TextAlign.center,
                      style: AppTheme.taskDescriptionTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                        decoration: TextDecoration.underline,
                      ),
                    )),
                const Spacer(),
                //edit button
                ElevatedButton(
                    onPressed: () {
                      editTask.title = titleController.text;
                      editTask.description = descriptionController.text;
                      editTask.date = selectedDate;

                      FirebaseFirestore.instance
                          .collection(MyUser.collectionName)
                          .doc(MyUser.currentUser!.id)
                          .collection(TaskModel.collectionName)
                          .doc(editTask.id)
                          .update(editTask.toJsonTask(editTask))
                          .then((_) {
                        listProvider.refreshToDos();
                        Navigator.pop(context);
                        setState(() {});
                      });
                    },
                    child: Text(context.l10n.save_changes))
              ],
            ),
          )
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
    editTask.date = selectedDate;
    setState(() {});
  }
}
