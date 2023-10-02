import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/screens.dart/product_feature/add_product_screen.dart';

import '../../helpers/navigator.dart';
import '../../providers/show_items_provider.dart';
import '../../widgets/button.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/list_tile_card.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/snac_bar.dart';
import '../../widgets/texts.dart';

class SuppliersScreen extends ConsumerStatefulWidget {
  const SuppliersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllBrandScreenState();
}

class _AllBrandScreenState extends ConsumerState<SuppliersScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          title: const MyText(
              text: "All Suppliers", weight: FontWeight.bold, size: 24)),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.white),
        margin: const EdgeInsets.only(top: 24),
        child: Column(children: [
          const SizedBox(height: 24),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => refresh(),
              child: FutureBuilder(
                  future:
                      ref.read(displayProductsProvider.notifier).getSuppliers(),
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
                      return ListView.separated(
                        itemBuilder: (_, i) {
                          final supplier = snapshot.requireData[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ListTileCard(
                              title: supplier.supplierName,
                              boldTitle: true,
                              titleSize: 16,
                              onEdit: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AddSupplierDialog(
                                            supplier: supplier,
                                          ),
                                        ],
                                      );
                                    });
                              },
                              onDelete: () {
                                MyDialogs.showConfirm(context,
                                    title: "Delete Brand",
                                    message:
                                        "Do you really want to delete this brand",
                                    onAcceptLabel: () async {
                                  MyNavigator.back(context);
                                  final res = await ref
                                      .read(displayProductsProvider.notifier)
                                      .deleteSupplier(supplier);
                                  if (res.isError) {
                                    print("error is ${res.error}");
                                    if (mounted) {
                                      MySnackBar.showSnack(
                                          res.error ?? "", context);
                                    }
                                  }
                                });
                              },
                              editIcon: Icon(Icons.edit),
                              subTitleColor: Colors.grey,
                              subTitle:
                                  " \n${supplier.supplierAddress} \n${supplier.supplierContact} | "
                                  "${supplier.supplierContact}",
                              deleteIcon: const Icon(Icons.delete),
                            ),
                          );
                        },
                        itemCount: snapshot.requireData.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      );
                    }
                    return Center(
                      child: MyText(
                        text: snapshot.error?.toString() ?? "",
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                    );
                  }),
            ),
          )
        ]),
      ),
    );
  }
}
