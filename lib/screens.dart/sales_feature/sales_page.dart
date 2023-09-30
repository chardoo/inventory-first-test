import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/providers/product_provider.dart';
import 'package:rich_co_inventory/providers/sales_provider.dart';
import 'package:rich_co_inventory/providers/show_items_provider.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

import '../../widgets/list_tile_card.dart';
import '../../widgets/shimmer_loader.dart';
import '../dashboard_feauture/dashboard.dart';

class SalesPage extends ConsumerStatefulWidget {
  const SalesPage({super.key});

  @override
  ConsumerState<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends ConsumerState<SalesPage> {
  void refresh() {
    setState(() {});
    return;
  }

  DateTime? startTime;
  DateTime? endTime;
  double totalSale = 0.0;
  String? format(DateTime? date) {
    DateFormat d = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY);
    if (date == null) return null;
    return d.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final date = ref.watch(dateProvider);
    return Scaffold(
        appBar: AppBar(title: const Text("All Sales")),
        body: Column(
          children: [
            const SizedBox(height: 24),
            Consumer(builder: (context, ref, _) {
              return MyText(
                  text: "Total: ${ref.watch(salesProvider).total}",
                  weight: FontWeight.bold,
                  size: 24);
            }),
            Consumer(builder: (context, ref, _) {
              final date = ref.watch(dateProvider);
              final dateRef = ref.read(dateProvider.notifier);
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyIconButton(
                      label: format(date.start) ?? "start",
                      forgroundColor: Colors.grey,
                      borderColor: Colors.grey,
                      bgColor: Colors.white,
                      icon: const RotatedBox(
                          quarterTurns: 3, child: Icon(Icons.chevron_left)),
                      ontap: () async {
                        dateRef.state = (start: null, end: date.end);
                        final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 1000)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 1000)));
                        dateRef.state = (start: selectedDate, end: date.end);
                        if (date.start != null && date.end != null) {
                          refresh();
                        }
                      },
                    ),
                    MyIconButton(
                        label: format(date.end) ?? "endDate",
                        forgroundColor: Colors.grey,
                        borderColor: Colors.grey,
                        bgColor: Colors.white,
                        ontap: () async {
                          dateRef.state = (start: date.start, end: null);
                          final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 1000)),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 1000)));
                          dateRef.state =
                              (start: date.start, end: selectedDate);

                          if (date.start != null && date.end != null) {
                            refresh();
                          }
                        },
                        icon: const RotatedBox(
                            quarterTurns: 3, child: Icon(Icons.chevron_left))),
                  ],
                ),
              );
            }),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => refresh(),
                child: FutureBuilder(
                    future: ref
                        .read(salesProvider.notifier)
                        .getSalesForDuration(date.start, date.end),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ShimmerLoader();
                      }

                      if (snapshot.hasData) {
                        if (snapshot.requireData.isEmpty) {
                          return const Center(
                            child: MyText(
                              text: "No Purchases yet",
                              size: 24,
                              weight: FontWeight.bold,
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (_, i) {
                                  final sale = snapshot.requireData[i];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: ListTileCard(
                                      title: sale.productName,
                                      subTitle: "View detail",
                                      icon: Icon(Icons.delete),
                                    ),
                                  );
                                },
                                itemCount: snapshot.requireData.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider();
                                },
                              ),
                            ),
                          ],
                        );
                      }

                      return Center(
                        child: MyText(
                          text: "${snapshot.error}${snapshot.hasError}" ?? "",
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                      );
                    }),
              ),
            )
          ],
        ));
  }
}
