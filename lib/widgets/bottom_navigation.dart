import 'package:flutter/material.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';

import '../screens.dart/add_to_product/add_product_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (value) {
          if (value == 0) {
            MyNavigator.goto(context, AddProductScreen());
          } else if (value == 1) {
            MyNavigator.goto(context, AddProductScreen());
          } else {
            MyNavigator.goto(context, AddProductScreen());
          }
        },
        unselectedItemColor: Color.fromARGB(255, 141, 137, 137),
        // backgroundColor: Color.fromARGB(255, 10, 13, 17),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Products',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
            ),
            label: 'Add Sales',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'inventory',
          )
        ]);
  }
}
