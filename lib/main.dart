import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rich_co_inventory/helpers/secure_store.dart';
import 'package:rich_co_inventory/providers/user_provider.dart';
import 'package:rich_co_inventory/screens.dart/auth/log_in.dart';

import 'package:rich_co_inventory/screens.dart/dashboard_feauture/dashboard.dart';
import 'package:rich_co_inventory/screens.dart/dashboard_feauture/drawer.dart';

import 'package:rich_co_inventory/screens.dart/inventory/all_inventory.dart';
import 'package:rich_co_inventory/screens.dart/product_feature/add_product_screen.dart';
import 'package:rich_co_inventory/screens.dart/product_feature/products_screen.dart';
import 'package:rich_co_inventory/screens.dart/sales_feature/add_sales.dart';
import 'package:rich_co_inventory/screens.dart/sales_feature/sales_page.dart';
import 'package:rich_co_inventory/widgets/bottom_navigation.dart';

import 'firebase_options.dart';
import 'helpers/navigator.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final isLogedIn = await Storage.getUser();
  String path = isLogedIn.isLoggedIn ? MyNavigator.home : MyNavigator.logIn;
  runApp(MyApp(
    initialRoute: path,
  ));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, _) {
      return ProviderScope(
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.pink,
            appBarTheme: const AppBarTheme(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                elevation: 1),
            useMaterial3: false,
          ),
          routes: {
            MyNavigator.logIn: (context) => const LogInScreen(),
            MyNavigator.home: (context) => const HomeScreen(),
            MyNavigator.addProduct: (context) => const AddProductScreen(),
            MyNavigator.addSales: (context) => AddSalesScreen(),
            MyNavigator.salesPage: (context) => const SalesPage()
          },
          initialRoute: initialRoute,
        ),
      );
    });
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    Future.microtask(() => ref.read(userProvider.notifier).init());
    super.initState();
  }

  final List<Widget> screens = [
    const DashBoard(),
    const ProductsScreen(),
    const AllInventory(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        disabledElevation: 0,
        onPressed: () {
          MyNavigator.goto(context, AddSalesScreen());
        },
        child: const Icon(Icons.shopping_cart),
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
