import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/screens.dart/auth/log_in.dart';
import 'package:rich_co_inventory/screens.dart/dashboard.dart';
import 'package:rich_co_inventory/screens.dart/product_display/products_screen.dart';
import 'package:rich_co_inventory/screens.dart/profile_screen.dart';
import 'package:rich_co_inventory/screens.dart/stocks_screen.dart';
import 'package:rich_co_inventory/widgets/bottom_navigation.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomeScreen()),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> screens = [
    DashBoard(),
    ProductsScreen(),
    StocksScreen(),
    ProfileScreen()
  ];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        disabledElevation: 0,
        onPressed: () {},
      ),
      bottomNavigationBar: BottomNavigation(
        ontap: (val) {
          setState(() {
            index = val;
          });
        },
      ),
    );
  }
}
