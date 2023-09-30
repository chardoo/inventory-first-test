import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/models/brand.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/providers/show_items_provider.dart';
import 'package:rich_co_inventory/providers/product_provider.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';
import 'package:rich_co_inventory/repository/sections/brand_apis.dart';
import 'package:rich_co_inventory/repository/sections/suppliers_api.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/loading_layout.dart';
import 'package:rich_co_inventory/widgets/snac_bar.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

import '../../helpers/validators.dart';
import '../../widgets/dropdown_with_labels.dart';
import '../../widgets/texts.dart';

part './sections/lower_section.dart';
part './sections/upper_section.dart';
part 'sections/product_dialogs.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({this.product, super.key});
  final Product? product;
  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final TextEditingController productController = TextEditingController();

  final TextEditingController brandController = TextEditingController();

  final TextEditingController supplierController = TextEditingController();

  final TextEditingController productDescriptionCont = TextEditingController();
  final TextEditingController priceCont = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  @override
  @override
  void dispose() {
    productController.dispose();
    brandController.dispose();
    supplierController.dispose();
    productDescriptionCont.dispose();
    priceCont.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool updatePage = widget.product != null;

    return LoadingLayout(
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            leading: const BackButton(color: Colors.black),
            title: MyText(
              text: updatePage ? "Update Product" : "Add product",
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
                            product: widget.product,
                            productController: productController,
                            brandController: brandController,
                            supplierController: supplierController,
                            productDescriptionCont: productDescriptionCont),
                        const SizedBox(height: 50),
                        _LowerSection(
                          product: widget.product,
                          priceCont: priceCont,
                          dateController: dateController,
                          addProduct: () async {
                            final state = ref.read(addProductProvider);

                            if (state.brand == null) {
                              MySnackBar.showSnack(
                                  "please select a valid brand", context);
                              return;
                            } else if (state.supplier == null) {
                              MySnackBar.showSnack(
                                  "please select a valid supply", context);
                              return;
                            }
                            final notifier =
                                ref.read(addProductProvider.notifier);

                            if (state.brand == null && state.supplier == null) {
                              MySnackBar.showSnack(
                                  "please fill in all the fields", context);
                              return;
                            }
                            var (isErr, err) =
                                MyValidators.isNotNumberAndIsEmpty(
                                    priceCont.text);
                            if (isErr) {
                              MySnackBar.showSnack(err, context);
                              return;
                            }
                            final id =
                                await createAndAddProduct(notifier, state);
                            if (id == null) return;
                            createAndAddStock(notifier, id);
                            if (mounted) {
                              MyNavigator.back(context);
                            }
                            ref
                                .read(displayProductsProvider.notifier)
                                .getProducts();
                          },
                        )
                      ]),
                ),
              ),
            ],
          )),
    );
  }

  createAndAddStock(AddProductProvider notifier, String productId) {
    Stock stock = Stock(
        productName: productController.text,
        productId: productId,
        productPrice: double.tryParse(priceCont.text),
        currentQuantity: 0,
        minimumRequiredQuantity: 10);
    notifier.addStock(stock, widget.product != null);
  }

  Future<String?> createAndAddProduct(
      AddProductProvider notifier, AddProductState state) async {
    final expiryDate =
        DateFormat(DateFormat.YEAR_MONTH_DAY).parse(dateController.text);
    Product product = Product(
        productId: widget.product?.productId,
        expiryDate: expiryDate.millisecondsSinceEpoch,
        productName: productController.text,
        price: double.tryParse(priceCont.text) ?? 0,
        supplierId: state.supplier!.supplierId,
        productDescription: productDescriptionCont.text,
        brandId: state.brand?.brandId);
    return await notifier.addProduct(product, widget.product != null);
  }
}
