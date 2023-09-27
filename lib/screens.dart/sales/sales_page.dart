import 'package:flutter/material.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Sales")),
      body: ListView.separated(
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              title: Text("Cotton t0shirt"),
              subtitle: MyText(
                text: "View detail",
                color: Colors.blue,
              ),
              trailing: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: Icon(
                  Icons.delete,
                  color: Colors.black54,
                ),
              ),
            ),
          );
        },
        itemCount: 50,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
