import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/extention_function/extention_function_l10n.dart';
import 'package:to_do_list/model/task_model.dart';
import 'package:to_do_list/providers/list_provider.dart';
import 'package:to_do_list/screens/edit_task.dart';
import 'package:to_do_list/utilities/app_theme.dart';

import '../../model/my_user.dart';

// ignore: must_be_immutable
class ToDoWidget extends StatefulWidget {
  TaskModel taskModel;

  ToDoWidget({super.key, required this.taskModel});

  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: AppTheme.customEdgeInsets(context),
      padding: AppTheme.customEdgeInsets(context),
      child: Slidable(
        //delete
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //delete button
            SlidableAction(
              onPressed: (context) {
                deleteTask();
              },
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
              icon: Icons.delete,
            ),
          ],
        ),
        //edit
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //edite button
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, EditTask.routeName,
                    arguments: widget.taskModel);
              },
              backgroundColor: Colors.green,
              borderRadius: BorderRadius.circular(12),
              icon: Icons.edit,
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: widget.taskModel.isDone == true
                    ? AppTheme.greenDone
                    : AppTheme.primaryBlue,
              ),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.height * 0.005,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.taskModel.title}",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: widget.taskModel.isDone == true
                            ? AppTheme.greenDone
                            : AppTheme.primaryBlue),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${widget.taskModel.description}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection(TaskModel.collectionName)
                        .doc(widget.taskModel.id)
                        .update({"isDone": !widget.taskModel.isDone!}).timeout(
                            const Duration(milliseconds: 500), onTimeout: () {
                      listProvider.refreshToDos();
                    });
                  },
                  child: Visibility(
                    visible: !widget.taskModel.isDone!,
                    child: Container(
                      padding: AppTheme.customEdgeInsets(context),
                      margin: AppTheme.customEdgeInsets(context),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppTheme.whiteColor,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection(TaskModel.collectionName)
                        .doc(widget.taskModel.id)
                        .update({"isDone": !widget.taskModel.isDone!}).timeout(
                            const Duration(milliseconds: 500), onTimeout: () {
                      listProvider.refreshToDos();
                    });
                  },
                  child: Visibility(
                    visible: widget.taskModel.isDone!,
                    child: Container(
                      padding: AppTheme.customEdgeInsets(context),
                      margin: AppTheme.customEdgeInsets(context),
                      child: Text(
                        context.l10n.done,
                        style: AppTheme.doneTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void deleteTask() {
    FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(MyUser.currentUser!.id)
        .collection(TaskModel.collectionName)
        .doc(widget.taskModel.id)
        .delete()
        .then((_) {
      listProvider.refreshToDos();
      setState(() {});
    });
  }
}
