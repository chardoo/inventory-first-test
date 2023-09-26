part of "./add_sales.dart";

class StockDetails extends ConsumerStatefulWidget {
  const StockDetails({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _StockDetails();
  }
}

class _StockDetails extends ConsumerState<StockDetails> {
  @override
  void initState() {
    super.initState();
  }

  final _quentityController = TextEditingController();

  String format(DateTime dateTime) {
    return DateFormat('d MMMM, y hh:mm a').format(dateTime);
  }

  @override
  dispose() {
    _quentityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Sale? currentSale = ref.watch(selectedSales);
    final cart = ref.watch(salesCartProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const MyText(
          text: "Configure product for sale",
          size: 24,
          weight: FontWeight.bold,
        ),
        const ListTile(
          leading: MyText(text: "Item"),
          title: MyText(text: "price per unit"),
          trailing: MyText(text: "quantity"),
        ),
        SizedBox(
          // height: 100,
          child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, i) {
                final item = cart[i];
                return ProductTile(item);
              },
              separatorBuilder: (_, i) {
                return Divider();
              },
              itemCount: cart.length),
        ),
      ]),
    );
  }
}

class ProductTile extends ConsumerStatefulWidget {
  const ProductTile(
    this.sale, {
    super.key,
  });
  final Sale sale;

  @override
  ConsumerState<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends ConsumerState<ProductTile> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    controller.text = widget.sale.quantitySold.toString();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.sale.productId),
      onDismissed: (direction) {
        ref.read(salesCartProvider.notifier).remove(widget.sale.productId);
      },
      child: ListTile(
        leading: MyText(
          text: widget.sale.productName,
          weight: FontWeight.bold,
          size: 16,
        ),
        title: MyText(
          text: widget.sale.productPrice.toString(),
          size: 16,
          weight: FontWeight.bold,
        ),
        trailing: Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade100),
            width: 140,
            child: Row(
              children: [
                GestureDetector(
                  child: Icon(Icons.add),
                ),
                VerticalDivider(),
                SizedBox(
                    width: 40,
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        final quentity = int.tryParse(val);
                        final updatedSale =
                            widget.sale.copyWith(quantitySold: quentity ?? 0);
                        ref
                            .read(salesCartProvider.notifier)
                            .update(updatedSale);
                      },
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
                VerticalDivider(),
                Icon(Icons.remove)
              ],
            )),
      ),
    );
  }
}
