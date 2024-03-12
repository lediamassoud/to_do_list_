import 'package:flutter/material.dart';
import 'package:to_do_list/model/task_model.dart';
import 'package:to_do_list/utilities/app_theme.dart';

class ToDoWidget extends StatelessWidget {
  TaskModel taskModel;

  ToDoWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: AppTheme.customEdgeInsets(context),
      padding: AppTheme.customEdgeInsets(context),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: AppTheme.primaryBlue,
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
                  "${taskModel.title}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppTheme.primaryBlue),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${taskModel.description}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Container(
            padding: AppTheme.customEdgeInsets(context),

            ///EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01,horizontal: MediaQuery.of(context).size.width * 0.04)
            margin: AppTheme.customEdgeInsets(context),

            /// EdgeInsets.all(MediaQuery.of(context).size.width * 0.02)
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.check,
              color: AppTheme.whiteColor,
            ),
          )
        ],
      ),
    );
  }
}
