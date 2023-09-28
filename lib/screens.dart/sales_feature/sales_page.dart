import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/providers/display_products_provider.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

class SalesPage extends ConsumerStatefulWidget {
  const SalesPage({super.key});

  @override
  ConsumerState<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends ConsumerState<SalesPage> {
  @override
  void initState() {
    Future.microtask(
        () => ref.read(displayProductsProvider.notifier).getSales());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("All Sales")),
        body: Column(
          children: [ref.watch(displayProductsProvider).display()],
        ));
  }
}

class SalesCard extends StatelessWidget {
  const SalesCard({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: const MyText(
        text: "View detail",
        color: Colors.blue,
      ),
      trailing: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(
              8,
            )),
        child: const Icon(
          Icons.delete,
          color: Colors.black54,
        ),
      ),
    );
  }
}
