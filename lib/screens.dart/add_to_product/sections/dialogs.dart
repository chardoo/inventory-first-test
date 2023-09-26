part of '../add_product_screen.dart';
class _AddSupplierDialog extends ConsumerStatefulWidget {
  const _AddSupplierDialog();

  @override
  ConsumerState<_AddSupplierDialog> createState() => _AddSupplierDialogState();
}

class _AddSupplierDialogState extends ConsumerState<_AddSupplierDialog> {
  final labels = ["name", "email", "address", "contact"];
  final hintTexts = [
    "enter supplier name",
    "enter email",
    "enter address",
    "enter contact"
  ];
  final controllers = List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (var cntl in controllers) {
      cntl.dispose();
    }
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
          controllers: controllers,
          onComplete: () {
            Supplier supplier = Supplier(
                supplierName: controllers[0].text,
                supplierEmail: controllers[1].text,
                supplierAddress: controllers[2].text,
                supplierContact: controllers[3].text);
            ref.read(addProductProvider.notifier).addSupplier(supplier);
          },
        ),
        ref.watch(loadingStateProvider).show(context)
      ],
    );
  }
}

class _AddBrandDialog extends ConsumerStatefulWidget {
  const _AddBrandDialog();

  @override
  ConsumerState<_AddBrandDialog> createState() => _AddBrandDialogState();
}

class _AddBrandDialogState extends ConsumerState<_AddBrandDialog> {
  final labels = [
    "name",
    "description",
  ];
  final hintTexts = ["enter brand name", "enter description"];
  final controllers = List.generate(2, (index) => TextEditingController());
  @override
  void dispose() {
    for (var cntl in controllers) {
      cntl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyDialogWithTitles(
          labels: labels,
          hintText: hintTexts,
          controllers: controllers,
          title: "Create Brand",
          onComplete: () async {
            Brand brand = Brand(
              brandName: controllers[0].text,
              brandDescription: controllers[1].text,
            );
            ref.read(addProductProvider.notifier).addBrand(brand);
          },
        ),
        ref.watch(loadingStateProvider).show(context)
      ],
    );
  }
}
