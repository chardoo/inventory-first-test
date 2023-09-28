import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../helpers/navigator.dart';
import '../../providers/show_items_provider.dart';
import '../shared/widgets/button.dart';
import '../shared/widgets/texts.dart';

class AllBrandScreen extends ConsumerStatefulWidget {
  const AllBrandScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllBrandScreenState();
}

class _AllBrandScreenState extends ConsumerState<AllBrandScreen> {
  @override
  void initState() {
    Future.microtask(
        () => ref.read(displayProductsProvider.notifier).getBrand());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          title: const MyText(
              text: "All Brands", weight: FontWeight.bold, size: 24)),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.white),
        margin: const EdgeInsets.only(top: 24),
        child: Column(children: [
          const SizedBox(height: 24),
          ref.watch(displayProductsProvider).display()
        ]),
      ),
    );
  }
}
