import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/helpers/secure_store.dart';
import 'package:rich_co_inventory/screens.dart/auth/log_in.dart';

import 'package:rich_co_inventory/screens.dart/dashboard_feauture/dashboard.dart';
import 'package:rich_co_inventory/screens.dart/dashboard_feauture/drawer.dart';

import 'package:rich_co_inventory/screens.dart/inventory/all_inventory.dart';
import 'package:rich_co_inventory/screens.dart/product_feature/add_product_screen.dart';
import 'package:rich_co_inventory/screens.dart/product_feature/products_screen.dart';
import 'package:rich_co_inventory/screens.dart/purchase_feature/all_purchase_page.dart';
import 'package:rich_co_inventory/screens.dart/sales_feature/add_sales.dart';
import 'package:rich_co_inventory/widgets/bottom_navigation.dart';

import 'firebase_options.dart';
import 'helpers/navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  bool isLogedIn = await Storage.getLogIn();
  String path = isLogedIn ? "/" : "/logged-in";
  runApp(MyApp(
    initialRoute: path,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 1),
          useMaterial3: false,
        ),
        routes: {
          "/logged-in": (context) => const LogInScreen(),
          "/": (context) => const HomeScreen(),
          "/add-product": (context) => const AddProductScreen(),
          '/add-sales': (context) => AddSalesScreen()
        },
        initialRoute: initialRoute,
      ),
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
    AllInventory(),
    AllPurchaseScreen()
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: index == 0
          ? AppBar(
              actions: const [
                Icon(Icons.calendar_month_outlined),
                SizedBox(width: 10)
              ],
            )
          : null,
      resizeToAvoidBottomInset: false,
      body: screens[index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        disabledElevation: 0,
        onPressed: () {
          MyNavigator.goto(context, AddSalesScreen());
        },
        child: const Text("Add"),
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
