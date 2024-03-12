import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/tabs/list_tab/to_do_widget.dart';

import '../../providers/list_provider.dart';

class ListTab extends StatefulWidget {
  static const routeName = "toDoList";

  ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider listProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listProvider.refreshToDos();
    });
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: listProvider.allTasks.length,
          itemBuilder: (context, index) {
            return ToDoWidget(
                taskModel: listProvider.allTasks[index]); //ToDo:add in it tasks
          },
        )),
      ],
    );
  }
}
