import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rich_co_inventory/widgets/graph.dart';

import '../widgets/texts.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: 5,
            child: Text(
              "N",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
        ),
        actions: [
          Icon(Icons.calendar_month_outlined),
          SizedBox(width: 5),
          Icon(Icons.menu),
          SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            OverviewCard(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SummaryTile(
                      title: "New Sale",
                      icon: Icon(Icons.cases_outlined),
                      price: 2003.20,
                    ),
                    SummaryTile(
                      title: "New Sale",
                      icon: Icon(Icons.cases_outlined),
                      price: 2003.20,
                    )
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SummaryTile(
                      title: "New Sale",
                      icon: Icon(Icons.cases_outlined),
                      price: 2003.20,
                    ),
                    SummaryTile(
                      title: "New Sale",
                      icon: Icon(Icons.cases_outlined),
                      price: 2003.20,
                    )
                  ],
                )
              ],
            )
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
        bgColor: color ?? Colors.deepPurple.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              icon,
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: title,
                    color: Colors.grey,
                    weight: FontWeight.bold,
                  ),
                  MyText(text: "GHC $price", weight: FontWeight.bold)
                ],
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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              child: Icon(Icons.inventory_2),
            ),
            SizedBox(width: 10),
            Text(
              "Overview",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyIconButton(
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
                icon: Icon(Icons.download))
          ],
        ),
        SizedBox(height: 24),
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
        Divider(),
        Row(
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
        Divider()
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
  });
  final Color? borderColor;
  final Color? bgColor;
  final String? label;
  final Color? forgroundColor;
  final Widget? child;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
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
            SizedBox(
              width: 10,
            ),
            icon ?? const SizedBox.shrink()
          ]),
    );
  }
}
