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
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, i) {
                final item = cart[i];
                return ProductTile(item);
              },
              separatorBuilder: (_, i) {
                return const Divider();
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
    controller.text = widget.sale.quantitySold?.toString() ?? "1";
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.redAccent,
        width: double.infinity,
      ),
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
                  onTap: () => inCreaseOrDecreasePrice(true),
                  child: const Icon(Icons.add),
                ),
                const VerticalDivider(),
                SizedBox(
                    width: 40,
                    child: TextField(
                      controller: controller,
                      style:
                          TextStyle(color: isError ? Colors.red : Colors.black),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        final quentity = int.tryParse(val);
                        if (quentity == null) {
                          setState(() {
                            isError = true;
                          });
                        } else {
                          setState(() {
                            isError = false;
                          });
                        }
                        final updatedSale =
                            widget.sale.copyWith(quantitySold: quentity);
                        ref
                            .read(salesCartProvider.notifier)
                            .update(updatedSale);
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: controller.text.length > 1 ? 0 : 10),
                          border: InputBorder.none),
                    )),
                const VerticalDivider(),
                GestureDetector(
                    onTap: () => inCreaseOrDecreasePrice(false),
                    child: const Icon(Icons.remove))
              ],
            )),
      ),
    );
  }

  inCreaseOrDecreasePrice(bool increase) {
    int? quentity = int.tryParse(controller.text);
    if (quentity == null) return;
    if (quentity <= 1 && increase == false) {
    } else {
      increase ? quentity++ : quentity--;
    }

    final updatedSale = widget.sale.copyWith(quantitySold: quentity);
    ref.read(salesCartProvider.notifier).update(updatedSale);
    controller.text = quentity.toString();
  }
}
