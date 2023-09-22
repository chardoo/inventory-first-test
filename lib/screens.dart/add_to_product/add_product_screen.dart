import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/models/brand.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/providers/add_product_controller.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

import '../../widgets/dropdown_with_labels.dart';
import '../../widgets/texts.dart';

part './sections/lower_section.dart';
part './sections/upper_section.dart';
part './sections/dialogs.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final TextEditingController productController = TextEditingController();

  final TextEditingController brandController = TextEditingController();

  final TextEditingController supplierController = TextEditingController();

  final TextEditingController productDescriptionCont = TextEditingController();
  final TextEditingController priceCont = TextEditingController();

  final TextEditingController initialStockCont = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  @override
  void dispose() {
    productController.dispose();
    brandController.dispose();
    supplierController.dispose();
    productController.dispose();
    priceCont.dispose();
    initialStockCont.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const MyText(
            text: "Add product",
            weight: FontWeight.bold,
            size: 24,
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _UpperSection(
                          productController: productController,
                          brandController: brandController,
                          supplierController: supplierController,
                          productDescriptionCont: productDescriptionCont),
                      const SizedBox(height: 50),
                      _LowerSection(
                        priceCont: priceCont,
                        initialStockCont: initialStockCont,
                        dateController: dateController,
                        addProduct: () async {
                          final state = ref.read(addProductProvider);
                          final notifier =
                              ref.read(addProductProvider.notifier);

                          if (state.brand == null && state.supplier == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("please fill in all the fields")));
                            return;
                          }
                          final id = await createAndAddProduct(notifier, state);
                          if (id == null) return;
                          createAndAddStock(notifier, id);
                        },
                      )
                    ]),
              ),
            ),
            ref.watch(loadingStateProvider).show(context)
          ],
        ));
  }

  createAndAddStock(AddProductProvider notifier, String productId) {
    Stock stock = Stock(
        productId: productId,
        currentQuantity: int.tryParse(initialStockCont.text) ?? 0,
        minimumRequiredQuantity: 10);
    notifier.addStock(stock);
  }

  Future<String?> createAndAddProduct(
      AddProductProvider notifier, AddProductState state) async {
    Product product = Product(
        productName: productController.text,
        price: double.tryParse(priceCont.text) ?? 0,
        supplierId: state.supplier!.supplierId,
        productDescription: productDescriptionCont.text,
        brandId: state.brand?.brandName);
    return await notifier.addProduct(product);
  }
}
