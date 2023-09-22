import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/models/brand.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/providers/add_product_controller.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

import '../../widgets/texts.dart';

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
                      ProductDetails(
                          productController: productController,
                          brandController: brandController,
                          supplierController: supplierController,
                          productDescriptionCont: productDescriptionCont),
                      const SizedBox(height: 50),
                      Consumer(builder: (context, ref, child) {
                        return StockDetails(
                          priceCont: priceCont,
                          initialStockCont: initialStockCont,
                          dateController: dateController,
                          addProduct: () {
                            final state = ref.read(addProductProvider);
                            if (state.brand != null && state.supplier != null) {
                              Product product = Product(
                                  productName: productController.text,
                                  price: double.tryParse(priceCont.text) ?? 0,
                                  supplierId: state.supplier!.supplierId,
                                  brandId: state.brand?.brandName);
                              ref
                                  .read(addProductProvider.notifier)
                                  .addProduct(product);
                            } else {
                              print(
                                  "state is ${state.brand} supplier ${state.supplier}");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "please fill in all the fields")));
                            }
                          },
                        );
                      })
                    ]),
              ),
            ),
            ref.watch(loadingStateProvider).show(context)
          ],
        ));
  }
}

class StockDetails extends StatefulWidget {
  const StockDetails({
    super.key,
    required this.priceCont,
    required this.initialStockCont,
    required this.dateController,
    this.addProduct,
  });
  final TextEditingController priceCont;
  final Function()? addProduct;
  final TextEditingController initialStockCont;

  final TextEditingController dateController;
  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  final format = DateFormat(DateFormat.YEAR_MONTH_DAY);
  DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    widget.dateController.text = format.format(currentDate);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const MyText(
          text: "Configure stock for this product",
          size: 24,
          weight: FontWeight.bold,
        ),
        const SizedBox(height: 24),
        const MyText(
          text: "product cost",
          weight: FontWeight.bold,
          size: 16,
        ),
        const SizedBox(height: 12),
        TextFieldWithDivider(
          controller: widget.priceCont,
        ),
        const SizedBox(height: 24),
        MyTextFieldWithTitle(
            name: "initial Stock",
            label: "",
            controller: widget.initialStockCont),
        const SizedBox(height: 24),
        MyTextFieldWithTitle(
          name: "input date",
          label: "",
          controller: widget.dateController,
          readOnly: true,
          ontap: () async {
            final selectedDate = await showDatePicker(
                currentDate: currentDate,
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 1000)),
                lastDate: DateTime.now().add(const Duration(days: 1000)));
            setState(() {
              currentDate = selectedDate ?? currentDate;
            });
          },
          trailing: const Icon(Icons.calendar_month),
        ),
        const SizedBox(height: 50),
        CustomButton(
          label: "Add product",
          ontap: widget.addProduct,
          width: double.infinity,
        )
      ]),
    );
  }
}

class ProductDetails extends ConsumerStatefulWidget {
  ProductDetails({
    super.key,
    required this.productController,
    required this.brandController,
    required this.supplierController,
    required this.productDescriptionCont,
  });
  final TextEditingController productController;

  final TextEditingController brandController;

  final TextEditingController supplierController;
  final TextEditingController productDescriptionCont;
  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MyTextFieldWithTitle(
            name: "Product name",
            label: "eg. coca cola",
            controller: widget.productController),
        const SizedBox(height: 12),
        const MyText(text: "Supplier"),
        Row(
          children: [
            Expanded(
                child: SearchDropDownMenu<Supplier>(
                    context: context,
                    itemBuilder: (context, value) {
                      return ListTile(title: Text(value.supplierName));
                    },
                    controller: widget.supplierController,
                    onSelected: (val) {
                      ref
                          .read(addProductProvider.notifier)
                          .addSupplierToState(val);
                      widget.supplierController.text = val.supplierName;
                    },
                    suggestionsCallback: (val) async {
                      return ref
                          .read(addProductProvider.notifier)
                          .searchSuppliers(val);
                    })),
            const SizedBox(
              width: 12,
            ),
            FilledButton.icon(
                style: FilledButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const _AddSupplierDialog();
                      });
                },
                icon: const Icon(Icons.add),
                label: const Text("New"))
          ],
        ),
        const SizedBox(height: 12),
        const MyText(text: "brand"),
        Row(
          children: [
            Expanded(
                child: SearchDropDownMenu<Brand>(
                    context: context,
                    itemBuilder: (context, value) {
                      return ListTile(title: Text(value.brandName));
                    },
                    controller: widget.brandController,
                    onSelected: (val) {
                      ref
                          .read(addProductProvider.notifier)
                          .addBrandToState(val);

                      widget.brandController.text = val.brandName;
                    },
                    suggestionsCallback: (val) async {
                      return ref
                          .read(addProductProvider.notifier)
                          .searchByName(val);
                    })),
            const SizedBox(
              width: 12,
            ),
            FilledButton.icon(
                style: FilledButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const _AddBrandDialog();
                      });
                },
                icon: const Icon(Icons.add),
                label: const Text("New"))
          ],
        ),
        const SizedBox(height: 12),
        MyTextFieldWithTitle(
            name: "product description",
            label: "Type something",
            lines: 5,
            controller: TextEditingController())
      ]),
    );
  }
}

class _AddSupplierDialog extends ConsumerStatefulWidget {
  const _AddSupplierDialog({
    super.key,
  });

  @override
  ConsumerState<_AddSupplierDialog> createState() => _AddSupplierDialogState();
}

class _AddSupplierDialogState extends ConsumerState<_AddSupplierDialog> {
  final nameCont = TextEditingController();

  final emailCont = TextEditingController();

  final addressCont = TextEditingController();

  final contactCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const MyText(text: "Create Supplier"),
                MyTextFieldWithTitle(
                    name: "name",
                    label: "enter supplier name",
                    controller: nameCont),
                MyTextFieldWithTitle(
                    name: "contact",
                    label: "enter contact",
                    controller: contactCont),
                MyTextFieldWithTitle(
                    name: "address",
                    label: "enter supplier contact",
                    controller: addressCont),
                MyTextFieldWithTitle(
                    name: "email",
                    label: "enter supplier email",
                    controller: emailCont),
                CustomButton(
                  label: "Add",
                  ontap: () async {
                    Supplier supplier = Supplier(
                        supplierName: nameCont.text,
                        supplierEmail: emailCont.text,
                        supplierContact: contactCont.text,
                        supplierAddress: addressCont.text);
                    ref.read(addProductProvider.notifier).addSupplier(supplier);
                  },
                )
              ]),
            ),
          ),
        ),
        ref.watch(loadingStateProvider).show(context)
      ],
    );
  }
}

class _AddBrandDialog extends ConsumerStatefulWidget {
  const _AddBrandDialog({
    super.key,
  });

  @override
  ConsumerState<_AddBrandDialog> createState() => _AddBrandDialogState();
}

class _AddBrandDialogState extends ConsumerState<_AddBrandDialog> {
  final nameCont = TextEditingController();

  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const MyText(text: "Create Brand"),
                MyTextFieldWithTitle(
                    name: "name",
                    label: "enter supplier name",
                    controller: nameCont),
                MyTextFieldWithTitle(
                    name: "contact",
                    label: "enter contact",
                    controller: descriptionController),
                CustomButton(
                  label: "Add",
                  ontap: () async {
                    Brand brand = Brand(
                      brandName: nameCont.text,
                      brandDescription: descriptionController.text,
                    );
                    ref.read(addProductProvider.notifier).addBrand(brand);
                  },
                )
              ]),
            ),
          ),
        ),
        ref.watch(loadingStateProvider).show(context)
      ],
    );
  }
}
