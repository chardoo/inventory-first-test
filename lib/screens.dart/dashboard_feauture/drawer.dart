import 'package:flutter/material.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/helpers/secure_store.dart';
import 'package:rich_co_inventory/screens.dart/inventory/all_inventory.dart';
import 'package:rich_co_inventory/screens.dart/purchase_feature/all_purchase_page.dart';
import 'package:rich_co_inventory/screens.dart/sales_feature/sales_page.dart';
import 'package:rich_co_inventory/widgets/dialogs.dart';

import '../../widgets/texts.dart';

import '../brand_feature/brand_screen.dart';
import '../supplier_feature.dart/suppliers_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  List<DrawerData> data(BuildContext context) {
    return [
      DrawerData("Inventory", const Icon(Icons.trolley), () {
        MyNavigator.goto(context, const AllInventory());
      }),
      DrawerData("See All Sales", const Icon(Icons.sell), () {
        MyNavigator.goto(context, const SalesPage());
      }),
      DrawerData("Brand", const Icon(Icons.money), () {
        MyNavigator.goto(context, const AllBrandScreen());
      }),
      DrawerData("Supplier", const Icon(Icons.person), () {
        MyNavigator.goto(context, const SuppliersScreen());
      }),
      DrawerData("Purchases", const Icon(Icons.store), () {
        MyNavigator.goto(context, const AllPurchaseScreen());
      }),
      DrawerData("log out", const Icon(Icons.logout), () {
        MyDialogs.showConfirm(context,
            title: "Log out",
            message: "Do u really want to log out ?", onAcceptLabel: () {
          MyNavigator.pushAndReplace(context, "/logged-in");
          Storage.storeUser(null, false);
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

class DrawerData {
  final String label;
  final Icon icon;
  final Function()? onTap;

  const DrawerData(this.label, this.icon, this.onTap);
}
