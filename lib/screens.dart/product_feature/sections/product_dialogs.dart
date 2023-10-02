part of '../add_product_screen.dart';

class AddSupplierDialog extends ConsumerStatefulWidget {
  const AddSupplierDialog({super.key, this.supplier});
  final Supplier? supplier;
  @override
  ConsumerState<AddSupplierDialog> createState() => _AddSupplierDialogState();
}

class _AddSupplierDialogState extends ConsumerState<AddSupplierDialog> {
  final labels = ["name", "email", "address", "contact"];
  @override
  initState() {
    super.initState();
    supplier = widget.supplier;
    if (supplier != null) {
      nameCntl = TextEditingController(text: supplier!.supplierName);
      emailCntl = TextEditingController(text: supplier!.supplierEmail);
      addressCntl = TextEditingController(text: supplier!.supplierAddress);
      contactCntl = TextEditingController(text: supplier!.supplierContact);
    }
  }

  Supplier? supplier;
  final hintTexts = [
    "enter supplier name",
    "enter email",
    "enter address",
    "enter contact"
  ];
  late TextEditingController nameCntl;
  late TextEditingController emailCntl;
  late TextEditingController addressCntl;
  late TextEditingController contactCntl;

  @override
  void dispose() {
    nameCntl.dispose();
    emailCntl.dispose();
    addressCntl.dispose();
    contactCntl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyDialogWithTitles(
          title: "Create Supplier",
          labels: labels,
          hintText: hintTexts,
          controllers: [nameCntl, emailCntl, addressCntl, contactCntl],
          onComplete: () async {
            Supplier supplier = Supplier(
                supplierId: widget.supplier?.supplierId,
                supplierName: nameCntl.text,
                supplierEmail: emailCntl.text,
                supplierAddress: addressCntl.text,
                supplierContact: contactCntl.text);
            MyNavigator.back(context);
            final res = await ref
                .read(addProductProvider.notifier)
                .addSupplier(supplier, widget.supplier != null);

            if (res.isError && mounted) {
              MySnackBar.showSnack(res.error!, context);
            }
          },
        ),
        ref.watch(loadingStateProvider).show(context)
      ],
    );
  }
}

class AddBrandDialog extends ConsumerStatefulWidget {
  const AddBrandDialog({super.key, this.brand});
  final Brand? brand;
  @override
  ConsumerState<AddBrandDialog> createState() => _AddBrandDialogState();
}

class _AddBrandDialogState extends ConsumerState<AddBrandDialog> {
  @override
  initState() {
    super.initState();
    if (widget.brand != null) {
      nameCntl = TextEditingController(text: widget.brand!.brandName);
      descriptionCntl =
          TextEditingController(text: widget.brand!.brandDescription);
    }
  }

  final labels = [
    "name",
    "description",
  ];
  final hintTexts = ["enter brand name", "enter description"];
  late TextEditingController nameCntl;
  late TextEditingController descriptionCntl;
  @override
  void dispose() {
    nameCntl.dispose();
    descriptionCntl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyDialogWithTitles(
          labels: labels,
          hintText: hintTexts,
          controllers: [nameCntl, descriptionCntl],
          title: "Create Brand",
          onComplete: () async {
            Brand brand = Brand(
              brandId: widget.brand?.brandId,
              brandName: nameCntl.text,
              brandDescription: descriptionCntl.text,
            );
            MyNavigator.back(context);

            ref
                .read(addProductProvider.notifier)
                .addBrand(brand, widget.brand != null);
          },
        ),
        ref.watch(loadingStateProvider).show(context)
      ],
    );
  }
}
