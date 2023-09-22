part of '../add_product_screen.dart';

class _UpperSection extends ConsumerStatefulWidget {
  const _UpperSection({
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
  ConsumerState<_UpperSection> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<_UpperSection> {
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
            controller: widget.productDescriptionCont)
      ]),
    );
  }
}
