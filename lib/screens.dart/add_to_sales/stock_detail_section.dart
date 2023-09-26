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

  List<Widget> salesCart(WidgetRef ref) {
    final selected = ref.watch(selectedSales);
    return ref.watch(salesCartProvider).map((e) {
      return GestureDetector(
        onTap: () {
          ref.read(selectedSales.notifier).set(e);
        },
        child: Chip(
          backgroundColor: e.productId == selected?.productId
              ? Colors.blue
              : Colors.grey.shade300,
          label: Text(e.productName),
          onDeleted: () {
            ref.read(salesCartProvider.notifier).remove(e.productId);
          },
          deleteIcon: const Icon(Icons.close),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Sale? currentSale = ref.watch(selectedSales);
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
        Wrap(spacing: 10, children: salesCart(ref)),
        const SizedBox(height: 24),
        const MyText(
          text: "product cost",
          weight: FontWeight.bold,
          size: 16,
        ),
        const SizedBox(height: 12),
        TextFieldWithDivider(
          label: "${currentSale?.productPrice ?? 0.00}",
          enabled: false,
        ),
        const SizedBox(height: 24),
        MyTextFieldWithTitle(
          name: "quentity sold",
          controller: _quentityController,
          label: "${currentSale?.quantitySold}",
          onChanged: (val) {
            try {
              currentSale?.quantitySold = int.parse(val);
              ref
                  .read(selectedSales.notifier)
                  .update(quentity: currentSale!.quantitySold);
            } catch (e) {
              //TODO
            }
          },
          onEditingComplete: () {
            _quentityController.clear();
            primaryFocus?.unfocus();
          },
          keyboadType: TextInputType.number,
        ),
        const SizedBox(height: 24),
        MyTextFieldWithTitle(
          name: " date sold",
          label: currentSale?.saleDate == null
              ? ""
              : format(currentSale!.saleDate),
          readOnly: true,
          ontap: () async {
            final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 1000)),
                lastDate: DateTime.now().add(const Duration(days: 1000)));

            ref.read(selectedSales.notifier).update(saleDate: date);
            primaryFocus?.unfocus();
          },
          trailing: const Icon(Icons.calendar_month),
        ),
        const SizedBox(height: 50),
        CustomButton(
          label: "Add sales",
          ontap: () {
            final salesCart = ref.read(salesCartProvider);

            ref.read(addProductProvider.notifier).addAllSales(salesCart);
          },
          width: double.infinity,
        )
      ]),
    );
  }
}
