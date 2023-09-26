import 'package:flutter/material.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, required this.ontap});
  final Function(int val) ontap;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  Icon navIcon(IconData data) => Icon(data, color: Colors.grey);
  Icon activeIcon(IconData data) => Icon(data, color: Colors.blue);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (val) {
          currentIndex = val;
          widget.ontap(val);
        },
        currentIndex: currentIndex,
        unselectedItemColor: const Color.fromARGB(255, 141, 137, 137),
        // backgroundColor: Color.fromARGB(255, 10, 13, 17),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: navIcon(
              Icons.home,
            ),
            activeIcon: activeIcon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: navIcon(
              Icons.gif_box,
            ),
            activeIcon: activeIcon(Icons.gif_box),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: navIcon(
              Icons.factory,
            ),
            activeIcon: activeIcon(Icons.factory),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: navIcon(
              Icons.person,
            ),
            activeIcon: activeIcon(Icons.person),
            label: 'Purchase',
          )
        ]);
  }
}
