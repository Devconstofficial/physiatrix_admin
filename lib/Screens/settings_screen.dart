import 'package:flutter/material.dart';
import 'package:physiatrix_admin/Widgets/sidebar.dart';
import 'package:physiatrix_admin/Widgets/topbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white70,
        body: Row(children: [
          SideBar(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TopBar(),
          ])
        ]));
  }
}
