import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';

import '../widgets/dashboard_view.dart';
import '../menu/widgets/menu_view.dart';

class DashboardTabView extends StatefulWidget {
  const DashboardTabView({super.key});

  @override
  State<DashboardTabView> createState() => _DashboardTabViewState();
}

class _DashboardTabViewState extends State<DashboardTabView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldBody: _selectedIndex == 0 ? DashboardView() : const MenuView(),
      floatingActionButton: _selectedIndex == 0  ? FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        child:  Icon(Icons.add, color:  Theme.of(context).primaryColorLight, ),
        onPressed: () =>
            Navigator.of(context).pushNamed(RouteConstants.addTaskPath),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: ColorConstants.colorWhite,
        unselectedItemColor: Theme.of(context).dividerColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: StringConstants.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: StringConstants.menu,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
