part of '../add_product_screen.dart';

class _UpperSection extends ConsumerStatefulWidget {
  const _UpperSection({
    this.product,
    required this.productController,
    required this.brandController,
    required this.supplierController,
    required this.productDescriptionCont,
  });
  final TextEditingController productController;
  final Product? product;
  final TextEditingController brandController;

  final TextEditingController supplierController;
  final TextEditingController productDescriptionCont;
  @override
  ConsumerState<_UpperSection> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<_UpperSection> {
  @override
  initState() {
    if (widget.product != null) {
      print("brand is in intit");
      getBrand();
      getsupplier();
      widget.productDescriptionCont.text = widget.product!.productDescription!;
      widget.productController.text = widget.product!.productName;
    }
    super.initState();
  }

  getBrand() async {
    final brand = await BrandAPIs().getOne(widget.product!.brandId!);
    if (brand == null) return;
    widget.brandController.text = brand.brandName;
    ref.read(addProductProvider.notifier).addBrandToState(brand);
    setState(() {});
    return;
  }

  getsupplier() async {
    final supplier = await SuppliersApis().getOne(widget.product!.supplierId!);
    if (supplier == null) return;
    ref.read(addProductProvider.notifier).addSupplierToState(supplier);

    widget.supplierController.text = supplier.supplierName;
    setState(() {});
  }

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
            MyFilledIconButton(
                icon: const Icon(Icons.add),
                label: const Text("New"),
                ontap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const AddSupplierDialog();
                      });
                })
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
            MyFilledIconButton(
              ontap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return const AddBrandDialog();
                    });
              },
              label: const Text("New"),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        const SizedBox(height: 12),
        MyTextFieldWithTitle(
            name: "product description",
            label: "Type something",
            lines: 5,
            controller: widget.productDescriptionCont)
      ]),
    );
  }
}
