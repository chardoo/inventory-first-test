import 'package:flutter/material.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/screens.dart/sales/sales_page.dart';
import 'package:rich_co_inventory/screens.dart/stocks_screen.dart';

import 'texts.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  final data = const [
    _DrawerData("Stock", Icon(Icons.inventory), StocksScreen()),
    _DrawerData("See All Sales", Icon(Icons.food_bank), SalesPage()),
    _DrawerData("Brand", Icon(Icons.money), StocksScreen())
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: data
          .map((e) => ListTile(
                leading: e.icon,
                title: MyText(
                  text: e.label,
                  weight: FontWeight.bold,
                ),
                onTap: () {
                  MyNavigator.goto(context, e.screen);
                },
              ))
          .toList(),
    ));
  }
}

class _DrawerData {
  final String label;
  final Icon icon;
  final Widget screen;

  const _DrawerData(this.label, this.icon, this.screen);
}
