part of '../add_product_screen.dart';

class _LowerSection extends StatefulWidget {
  const _LowerSection({
    required this.priceCont,
    required this.dateController,
    this.addProduct,
    this.product,
  });
  final TextEditingController priceCont;
  final Product? product;
  final Function()? addProduct;

  final TextEditingController dateController;
  @override
  State<_LowerSection> createState() => _LowerSectionState();
}

class _LowerSectionState extends State<_LowerSection> {
  final format = DateFormat(DateFormat.YEAR_MONTH_DAY);
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    if (widget.product != null) {
      widget.priceCont.text = widget.product!.price.toString();
      currentDate =
          DateTime.fromMillisecondsSinceEpoch(widget.product!.expiryDate!);
      widget.dateController.text =
          currentDate.millisecondsSinceEpoch.toString();
    }
    super.initState();
  }

  bool isError = false;
  String errorMsg = "";
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
        Visibility(
            visible: isError,
            child: MyText(text: errorMsg, color: Colors.redAccent)),
        TextFieldWithDivider(
          onChanged: (val) {
            setState(() {
              var (isErr, err) = MyValidators.isNotNumberAndIsEmpty(val);
              print("err $isError, $err");
              errorMsg = err;
              isError = isErr;
            });
          },
          controller: widget.priceCont,
        ),
        const SizedBox(height: 24),
        MyTextFieldWithTitle(
          name: "expiry date",
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
              widget.dateController.text =
                  selectedDate!.millisecondsSinceEpoch.toString();
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
