import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/providers/sales_cart_provider.dart';
import 'package:rich_co_inventory/providers/sales_provider.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/dialogs.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/loading_layout.dart';
import 'package:rich_co_inventory/widgets/snac_bar.dart';
import '../../providers/product_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_render/pdf_render_widgets.dart' as pdfView;

import '../../widgets/texts.dart';
part './product_detail_section.dart';
part './stock_detail_section.dart';

class AddSalesScreen extends ConsumerWidget {
  AddSalesScreen({super.key});
  final List<Product> products = List.generate(
      5, (index) => const Product(productName: "productName", price: 2342));
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(salesCartProvider);
    return LoadingLayout(
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            leading: BackButton(
                color: Colors.black,
                onPressed: () => MyNavigator.back(context)),
            title: const MyText(
              text: "Add Sales",
              weight: FontWeight.bold,
              size: 24,
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              label: "Add sales",
              ontap: cart.isEmpty
                  ? null
                  : () async {
                      final salesCart = ref.read(salesCartProvider);
                      if (salesCart
                          .any((element) => element.quantitySold == null)) {
                        MySnackBar.showSnack(
                            "please enter a correct quantity", context);
                        return;
                      }

                      MyDialogs.showConfirm(context, title: "Add",
                          onAcceptLabel: () async {
                        MyNavigator.back(context);

                        final res = await ref
                            .read(salesProvider.notifier)
                            .addAllSales(salesCart);
                        final file = await save("${DateTime.now()}", salesCart);

                        if (!res.isError) {
                          if (context.mounted) {
                            MyNavigator.pushAndReplace(
                                context, MyNavigator.salesPage);
                            if (file != null) {
                              MyNavigator.goto(context, open(file.path));
                            }
                          }
                          return;
                        }
                        if (context.mounted) {
                          MySnackBar.showSnack(
                              res.error ?? "a problem occured", context);
                        }
                      }, message: "Do you really want to add ?");
                    },
              width: double.infinity,
            ),
          ),
          body: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProductDetails(),
                    SizedBox(height: 20),
                    StockDetails()
                  ]),
            ),
          )),
    );
  }

  Future<Uint8List> createPdf(List<Sale> sales) async {
    final pdf = pw.Document();
    final total = sales.map((e) {
      return e.quantitySold! * e.productPrice;
    }).reduce((value, element) => value + element);
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Column(
          children: [table(sales), pw.SizedBox(height: 20), pw.Text("$total")]);
    }));

    return pdf.save();
  }

  table(List<Sale> sales) {
    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(),
      headerAlignment: pw.Alignment.centerLeft,
      headers: ['Product Name', 'Price per Unit', 'Quantity'],
      data: sales
          .map((product) => [
                product.productName,
                product.productPrice.toStringAsFixed(2),
                product.quantitySold.toString(),
              ])
          .toList(),
    );
  }

  Future<File?> save(String fileName, List<Sale> sales) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    try {
      await file.writeAsBytes(await createPdf(sales));
      return file;
    } catch (e) {
      return null;
    }
  }

  Widget open(String path) {
    return Scaffold(
      body: pdfView.PdfViewer.openFile(
        path,
        onError: (e) {
          print("print error ${e}");
        },
      ),
    );
  }
}
