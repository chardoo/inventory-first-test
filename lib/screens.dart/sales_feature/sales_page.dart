import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/models/user.dart';
import 'package:rich_co_inventory/providers/sales_provider.dart';
import 'package:rich_co_inventory/providers/user_provider.dart';
import 'package:rich_co_inventory/widgets/dialogs.dart';
import 'package:rich_co_inventory/widgets/snac_bar.dart';
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
    if (start != null && end != null) {
      setState(() {});
      Future.delayed(const Duration(seconds: 1), () {
        start = null;
        end = null;
      });
    }
    return;
  }

  @override
  void initState() {
    Future.microtask(
        () => ref.read(dateProvider.notifier).state = (start: null, end: null));
    super.initState();
  }

  double totalSale = 0.0;
  String? format(DateTime? date) {
    DateFormat d = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY);
    if (date == null) return null;
    return d.format(date);
  }

  DateTime? start;
  DateTime? end;
  @override
  Widget build(BuildContext context) {
    final canFilter = ref.watch(userProvider)?.role != Role.user;
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
            Visibility(
              visible: canFilter,
              child: Consumer(builder: (context, ref, _) {
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
                          start = null;
                          dateRef.state = (start: null, end: date.end);
                          final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 1000)),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 1000)));
                          dateRef.state = (start: selectedDate, end: date.end);
                          start = selectedDate;
                          refresh();
                        },
                      ),
                      MyIconButton(
                          label: format(date.end) ?? "endDate",
                          forgroundColor: Colors.grey,
                          borderColor: Colors.grey,
                          bgColor: Colors.white,
                          ontap: () async {
                            end = null;
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

                            end = selectedDate;
                            refresh();
                          },
                          icon: const RotatedBox(
                              quarterTurns: 3,
                              child: Icon(Icons.chevron_left))),
                    ],
                  ),
                );
              }),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => refresh(),
                child: FutureBuilder(
                    future: ref
                        .read(salesProvider.notifier)
                        .getSalesForDuration(start, end),
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

                        final salesData = snapshot.requireData
                          ..sort((a, b) {
                            final dateA = DateTime.fromMillisecondsSinceEpoch(
                                b.dateWithTime);
                            final dateB = DateTime.fromMillisecondsSinceEpoch(
                                a.dateWithTime);
                            return dateA.compareTo(dateB);
                          });
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (_, i) {
                                  final sale = salesData[i];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: ListTileCard(
                                      title: sale.productName,
                                      subTitle: "View detail",
                                      onDelete: () {
                                        MyDialogs.showConfirm(context,
                                            title: "Delete sale",
                                            message:
                                                "Do you really want to delete this sale",
                                            onAcceptLabel: () async {
                                          MyNavigator.back(context);
                                          final res = await ref
                                              .read(salesProvider.notifier)
                                              .delete(sale);
                                          if (res.isError) {
                                            if (mounted) {
                                              MySnackBar.showSnack(
                                                  res.error ?? "", context);
                                            }
                                          }
                                        });
                                      },
                                      editIcon: const Icon(Icons.edit),
                                      deleteIcon: const Icon(Icons.delete),
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
                          text: "${snapshot.error}${snapshot.hasError}",
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
