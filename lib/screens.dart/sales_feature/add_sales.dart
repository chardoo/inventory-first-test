import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/providers/sales_cart_provider.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/dialogs.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/loading_layout.dart';
import 'package:rich_co_inventory/widgets/snac_bar.dart';
import '../../providers/product_provider.dart';
import '../../widgets/texts.dart';
part './product_detail_section.dart';
part './stock_detail_section.dart';

class AddSalesScreen extends ConsumerWidget {
  AddSalesScreen({super.key});
  final List<Product> products = List.generate(
      5, (index) => const Product(productName: "productName", price: 2342));
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(salesCartProvider);
    return LoadingLayout(
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            leading: BackButton(
                color: Colors.black,
                onPressed: () => MyNavigator.back(context)),
            title: const MyText(
              text: "Add Sales",
              weight: FontWeight.bold,
              size: 24,
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              label: "Add sales",
              ontap: cart.isEmpty
                  ? null
                  : () async {
                      final salesCart = ref.read(salesCartProvider);
                      if (salesCart
                          .any((element) => element.quantitySold == null)) {
                        MySnackBar.showSnack(
                            "please enter a correct quantity", context);
                        return;
                      }

                      MyDialogs.showConfirm(
                        
                        
                        context,
                        title: "Add",
                        
                         ontap: () async {
                        MyNavigator.back(context);

                        final res = await ref
                            .read(addProductProvider.notifier)
                            .addAllSales(salesCart);
                        if (res == "successfull") {
                          if (context.mounted) {
                            MyNavigator.backTo(context);
                          }
                          return;
                        }
                        if (context.mounted) {
                          MySnackBar.showSnack(
                              res ?? "a problem occured", context);
                        }
                      }, message: "Do you really want to add ?");
                    },
              width: double.infinity,
            ),
          ),
          body: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProductDetails(),
                    SizedBox(height: 20),
                    StockDetails()
                  ]),
            ),
          )),
    );
  }
}
