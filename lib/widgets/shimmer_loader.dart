import 'package:flutter/material.dart';
import 'package:rich_co_inventory/widgets/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (_, i) => const SizedBox(height: 12),
        itemCount: 10,
        itemBuilder: (_, i) {
          return const ListTile(
            title: ShimmerLayout(
              height: 20,
              width: 50,
            ),
            subtitle: ShimmerLayout(
              height: 20,
              width: 80,
            ),
            trailing: ShimmerLayout(
              height: 20,
              width: 20,
              shape: BoxShape.circle,
            ),
          );
        });
  }
}
