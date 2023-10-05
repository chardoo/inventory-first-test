import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/providers/product_provider.dart';
import 'package:rich_co_inventory/providers/purchase_provider.dart';
import 'package:rich_co_inventory/providers/sales_provider.dart';
import 'package:rich_co_inventory/screens.dart/dashboard_feauture/drawer.dart';
import 'package:rich_co_inventory/screens.dart/product_feature/products_screen.dart';
import 'package:rich_co_inventory/widgets/graph.dart';

import '../../widgets/texts.dart';

class DashBoard extends ConsumerStatefulWidget {
  const DashBoard({super.key});

  @override
  ConsumerState<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends ConsumerState<DashBoard> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(salesProvider.notifier).setSalesForDayAndWeek();
      ref.read(purchaseProvider.notifier).setWeeklyAndMonthlyPurchase();
    });
    super.initState();
  }

  String format(int dateTimeFromMillisec) {
    final d = DateTime.fromMillisecondsSinceEpoch(dateTimeFromMillisec);
    final format = DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY);
    return format.format(d);
  }

  @override
  Widget build(BuildContext context) {
    final salesState = ref.watch(salesProvider);
    final purchaseState = ref.watch(purchaseProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            // const OverviewCard(),
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  crossAxisCount: 2),
              children: [
                SummaryTile(
                  title: "Today's sales",
                  icon: const Icon(Icons.cases_outlined, color: Colors.blue),
                  price: salesState.todaySale,
                ),
                SummaryTile(
                  title: " Sales for the week",
                  icon: const Icon(Icons.cases_outlined, color: Colors.blue),
                  price: salesState.weekSales,
                ),
                SummaryTile(
                  title: "Total purchases for this week",
                  icon: const Icon(Icons.cases_outlined, color: Colors.blue),
                  price: purchaseState.weeklyTotal,
                ),
                SummaryTile(
                  title: "Total purchases for this month",
                  icon: const Icon(Icons.cases_outlined, color: Colors.blue),
                  price: purchaseState.monthlyTotal,
                ),
                SummaryTile(
                  title: "Highest purchase product for the week",
                  icon: const Icon(Icons.cases_outlined, color: Colors.blue),
                  price: purchaseState.monthlyTotal,
                )
              ],
            ),
            const SizedBox(height: 30),
            FutureBuilder(
                future: ref
                    .read(addProductProvider.notifier)
                    .getProductsNearingExpiry(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    if (snap.requireData == null) {
                      return const Center(
                        child: Text("something occured"),
                      );
                    } else if (snap.requireData!.isEmpty) {
                      return const Center(
                        child: Text("No expired products"),
                      );
                    } else {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snap.requireData!.length,
                          itemBuilder: (context, i) {
                            final product = snap.requireData![i];

                            return ProductCard(
                              product: product,
                              extraDetails:
                                  "Expiry date: ${format(product.expiryDate!)}",
                            );
                          });
                    }
                  }
                  return const SizedBox.shrink();
                })
          ]),
        ),
      ),
    );
  }
}

class SummaryTile extends StatelessWidget {
  const SummaryTile({
    super.key,
    required this.price,
    required this.title,
    required this.icon,
    this.color,
  });
  final double price;
  final String title;
  final Widget icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return MyIconButton(
        label: '',
        ontap: () {},
        bgColor: color ?? Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: MyText(
                  text: title,
                  maxLines: 3,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    icon,
                    MyText(
                        text: "GHC $price",
                        weight: FontWeight.bold,
                        color: Colors.blue)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              child: Icon(Icons.inventory_2),
            ),
            const SizedBox(width: 10),
            Text(
              "Overview",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MyIconButton(
                label: "Monthly",
                forgroundColor: Colors.grey,
                borderColor: Colors.grey,
                bgColor: Colors.white,
                icon: RotatedBox(
                    quarterTurns: 3, child: Icon(Icons.chevron_left))),
            MyIconButton(
                label: "Download Report",
                forgroundColor: Colors.blueAccent,
                bgColor: Colors.lightBlue.shade100,
                icon: const Icon(Icons.download))
          ],
        ),
        const SizedBox(height: 24),
        CustomGraph(
          points: [
            Point(0, 10),
            Point(2, 0),
            Point(3, 30),
            Point(4, 10),
            Point(5, 10),
            Point(6, 0),
            Point(7, 30),
            Point(8, 10)
          ],
        ),
        const Divider(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                MyText(
                  text: "Avg monthly profit",
                  size: 14,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    MyText(
                      text: "\$823.00",
                      size: 14,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_upward,
                      size: 14,
                      color: Colors.greenAccent,
                    ),
                    SizedBox(width: 5),
                    MyText(
                      text: "1.2%",
                      weight: FontWeight.bold,
                      size: 14,
                      color: Colors.greenAccent,
                    )
                  ],
                )
              ],
            ),
            Column(
              children: [
                MyText(
                  text: "Spent this month",
                  size: 14,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    MyText(
                      text: "\$440.00",
                      weight: FontWeight.bold,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_downward,
                      size: 14,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5),
                    MyText(
                      text: "1.2%",
                      weight: FontWeight.bold,
                      size: 14,
                      color: Colors.red,
                    )
                  ],
                )
              ],
            )
          ],
        ),
        const Divider()
      ]),
    );
  }
}

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    super.key,
    this.borderColor,
    this.bgColor,
    required this.label,
    this.icon,
    this.forgroundColor,
    this.child,
    this.ontap,
  });
  final Color? borderColor;
  final Color? bgColor;
  final String? label;
  final Color? forgroundColor;
  final Widget? child;
  final Widget? icon;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: ontap ?? () {},
      style: FilledButton.styleFrom(
          elevation: 2,
          backgroundColor: bgColor,
          foregroundColor: forgroundColor,
          shape: RoundedRectangleBorder(
              side: borderColor != null
                  ? BorderSide(color: borderColor!)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(8))),
      child: child ??
          Row(children: [
            Text(label ?? ""),
            const SizedBox(
              width: 10,
            ),
            icon ?? const SizedBox.shrink()
          ]),
    );
  }
}
