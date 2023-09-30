import 'package:flutter/material.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/helpers/secure_store.dart';
import 'package:rich_co_inventory/screens.dart/inventory/all_inventory.dart';
import 'package:rich_co_inventory/screens.dart/sales_feature/sales_page.dart';
import 'package:rich_co_inventory/screens.dart/stocks_feature/stocks_screen.dart';
import 'package:rich_co_inventory/widgets/dialogs.dart';

import '../../widgets/texts.dart';
import 'package:rich_co_inventory/screens.dart/stocks_feature/stocks_screen.dart';

import '../brand_feature/brand_screen.dart';
import '../supplier_feature.dart/suppliers_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  List<_DrawerData> data(BuildContext context) {
    return [
      _DrawerData("Inventory", const Icon(Icons.inventory), () {
        MyNavigator.goto(context, const AllInventory());
      }),
      _DrawerData("See All Sales", const Icon(Icons.food_bank), () {
        const SalesPage();
      }),
      _DrawerData("Brand", const Icon(Icons.money), () {
        const AllBrandScreen();
      }),
      _DrawerData("Supplier", const Icon(Icons.person), () {
        const SuppliersScreen();
      }),
      _DrawerData("log out", const Icon(Icons.logout), () {
        MyDialogs.showConfirm(context,
            title: "Log out",
            message: "Do u really want to log out ?", onAcceptLabel: () {
          MyNavigator.pushAndReplace(context, "/logged-in");
          Storage.setLogIn(false);
        });
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: data(context)
          .map((e) => ListTile(
                leading: e.icon,
                title: MyText(
                  text: e.label,
                  weight: FontWeight.bold,
                ),
                onTap: e.onTap,
              ))
          .toList(),
    ));
  }
}

class _DrawerData {
  final String label;
  final Icon icon;
  final Function()? onTap;

  const _DrawerData(this.label, this.icon, this.onTap);
}
