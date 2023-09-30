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
    return Scaffold(
        appBar: AppBar(title: const Text("All Sales")),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, right: 24, left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyIconButton(
                    label: format(startTime) ?? "start",
                    forgroundColor: Colors.grey,
                    borderColor: Colors.grey,
                    bgColor: Colors.white,
                    icon: const RotatedBox(
                        quarterTurns: 3, child: Icon(Icons.chevron_left)),
                    ontap: () async {
                      startTime = null;
                      final selectedDate = await showDatePicker(
                          // currentDate: currentDate,
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 1000)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 1000)));
                      startTime = selectedDate;
                     
                    },
                  ),
                  MyIconButton(
                      label: format(endTime) ?? "endDate",
                      forgroundColor: Colors.grey,
                      borderColor: Colors.grey,
                      bgColor: Colors.white,
                      ontap: () async {
                        final selectedDate = await showDatePicker(
                            // currentDate: currentDate,
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 1000)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 1000)));
                        endTime = selectedDate;

                        if (startTime != null && endTime != null) {
                          refresh();
                        }
                      },
                      icon: const RotatedBox(
                          quarterTurns: 3, child: Icon(Icons.chevron_left))),
                ],
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => refresh(),
                    child: FutureBuilder(
                        future: ref
                            .read(salesProvider.notifier)
                            .getSalesForDuration(startTime, endTime),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                const SizedBox(height: 10),
                                MyText(
                                  
                                    text: "Total: ${ref.watch(salesProvider).total}",
                                    weight: FontWeight.bold,
                                    size: 24),
                                const SizedBox(height: 100),
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
                              text:
                                  "${snapshot.error}${snapshot.hasError}" ?? "",
                              size: 24,
                              weight: FontWeight.bold,
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70, right: 24, left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyIconButton(
                    label: format(startTime) ?? "start",
                    forgroundColor: Colors.grey,
                    borderColor: Colors.grey,
                    bgColor: Colors.white,
                    icon: const RotatedBox(
                        quarterTurns: 3, child: Icon(Icons.chevron_left)),
                    ontap: () async {
                      startTime = null;
                      final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 1000)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 1000)));
                      startTime = selectedDate;
                    },
                  ),
                  MyIconButton(
                      label: format(endTime) ?? "endDate",
                      forgroundColor: Colors.grey,
                      borderColor: Colors.grey,
                      bgColor: Colors.white,
                      ontap: () async {
                        final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 1000)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 1000)));
                        endTime = selectedDate;

                        if (startTime != null && endTime != null) {
                          refresh();
                        }
                      },
                      icon: const RotatedBox(
                          quarterTurns: 3, child: Icon(Icons.chevron_left))),
                ],
              ),
            ),
          ],
        ));
  }
}
