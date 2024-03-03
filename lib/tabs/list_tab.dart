import 'package:flutter/material.dart';
import 'package:to_do_list/tabs/to_do_widget.dart';

class ListTab extends StatelessWidget {
  static const routeName = "toDoList";

  const ListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ToDoWidget();
          },
        )),
      ],
    );
  }
}
