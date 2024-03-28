import 'package:flutter/material.dart';
import 'package:to_do_list/bottom_sheet/add_bottom_sheet.dart';
import 'package:to_do_list/extention_function/extention_function_l10n.dart';
import 'package:to_do_list/tabs/list_tab/list_tab.dart';
import 'package:to_do_list/tabs/settings_tab/settings_tab.dart';
import 'package:to_do_list/utilities/app_theme.dart';

class Home extends StatefulWidget {
  static String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    ListTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppTheme.primaryLight,
      appBar: AppBar(
        title: Text(context.l10n.app_title),
      ),
      body: tabs[currentTabIndex],
      floatingActionButton: buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      clipBehavior: Clip.hardEdge,
      child: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: currentTabIndex,
        onTap: (newIndex) {
          currentTabIndex = newIndex;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "list"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "setting"),
        ],
      ),
    );
  }

  buildFAB() => FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: const AddBottomSheet(),
                  ));
        },
        shape: const StadiumBorder(
            side: BorderSide(color: AppTheme.whiteColor, width: 4)),
        child: const Icon(Icons.add),
      );
}
