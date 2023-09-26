import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class ShimmerLayout extends StatelessWidget {
  const ShimmerLayout({
    super.key,
    required this.width,
    required this.height,
    this.child,
    this.radius,
    this.shape = BoxShape.rectangle,
    this.shadow,
  });
  final double width;
  final double height;
  final BoxShape shape;
  final Widget? child;

  static Widget withAspectRatio(
    BuildContext context, {
    required double aspectRatio,
    required Axis direction,
  }) {
    Size size = MediaQuery.of(context).size;

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: SizedBox(
        height: direction == Axis.horizontal ? size.height : null,
        width: direction == Axis.vertical ? size.width : null,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Material(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  final double? radius;
  final bool? shadow;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              boxShadow: shadow == true
                  ? [
                      const BoxShadow(
                        color: Color.fromRGBO(51, 54, 55, 0.2),
                        blurRadius: 4.0,
                      ),
                    ]
                  : null,
              shape: shape,
              color: Colors.white,
              borderRadius:
                  radius != null ? BorderRadius.circular(radius!) : null),
          child: child,
        ));
  }
}
