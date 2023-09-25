import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/providers/purchase_provider.dart';

class Purchases extends ConsumerStatefulWidget {
  Purchases({super.key});

  @override
  ConsumerState<Purchases> createState() => _PurchasesState();
}

class _PurchasesState extends ConsumerState<Purchases> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
   Future.microtask(() {
      fkdksdkjsd();
   },
      
   );
   
  }

void fkdksdkjsd()async{
 //ref.read(purchaseProvider.notifier).getPurchase();
}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
     Column(children: [
       
       Text(ref.watch(purchaseProvider).me ==23? "fhhdfhf": "asumah"),


       ElevatedButton(onPressed:  () {
        // ref.read(purchaseProvider.notifier).changeinter();
       }, child: Text("presds"))

      ])
    
      
      
    );
    }

    

   
}