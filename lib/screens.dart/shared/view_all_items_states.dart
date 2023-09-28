import 'package:flutter/material.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/shimmer.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/texts.dart';

abstract class ProductDisplayState {
  Widget display();
}

class LoadingState extends ProductDisplayState {
  @override
  display() {
    print("hello here");
    return Expanded(
      child: ListView.separated(
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
          }),
    );
  }
}

class ErrorState extends ProductDisplayState {
  final String error;

  ErrorState(this.error);
  @override
  display() {
    return Center(
      child: MyText(
        text: error,
        size: 24,
        weight: FontWeight.bold,
      ),
    );
  }
}

class EmptyState extends ProductDisplayState {
  @override
  display() {
    return const Center(
      child: MyText(
        text: "No Items in store",
        size: 24,
        weight: FontWeight.bold,
      ),
    );
  }
}

abstract class SuccessState<T> extends ProductDisplayState {
  final T data;

  SuccessState(this.data);
}
