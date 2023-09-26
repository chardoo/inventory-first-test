part of "./add_sales.dart";

class _ProductDetails extends StatefulWidget {
  const _ProductDetails();

  @override
  State<_ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<_ProductDetails> {
  TextEditingController productCntl = TextEditingController();

  TextEditingController supplierCntl = TextEditingController();

  TextEditingController brandCntl = TextEditingController();

  @override
  dispose() {
    productCntl.dispose();
    supplierCntl.dispose();
    brandCntl.dispose();
    super.dispose();
  }

  List<Product> products = List.generate(
      5, (index) => const Product(productName: "productName", price: 34323));
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1),
              color: Colors.grey.shade100),
          child: const Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                MyText(
                  text: "Gabriel Samsudin",
                  weight: FontWeight.bold,
                  size: 24,
                ),
                MyText(text: "ID: NSB00012341")
              ]),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const MyText(text: "Select Product", weight: FontWeight.bold),
        Consumer(builder: (context, ref, _) {
          return SearchDropDownMenu<Product>(
              label: "eg. cocoa butter",
              context: context,
              itemBuilder: (context, value) {
                return ListTile(title: Text(value.productName));
              },
              controller: productCntl,
              onSelected: (val) {
                Sale sale = Sale(
                    productId: val.productId!,
                    saleDate: DateTime.now(),
                    quantitySold: 0,
                    productName: val.productName,
                    productPrice: val.price,
                    totalRevenue: 0);
                ref.read(selectedSales.notifier).set(sale);

                ref.read(salesCartProvider.notifier).add(val);
                productCntl.text = val.productName;
              },
              suggestionsCallback: (val) async {
                return ref
                    .read(addProductProvider.notifier)
                    .searchProductByName(val);
              });
        }),
        const SizedBox(height: 20),
      ]),
    );
  }
}
