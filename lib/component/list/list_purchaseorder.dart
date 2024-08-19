//import 'package:flutter/cupertino.dart';
 
 
 
import 'package:barcode_inventory_new/component/form/purchaseorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
 

class List_PurchaseOrder extends StatefulWidget {
  const List_PurchaseOrder({super.key});

  @override
  State<List_PurchaseOrder> createState() => _List_PurchaseOrderState();
}

class _List_PurchaseOrderState extends State<List_PurchaseOrder> {
  final _Search_PO=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Purchase Order List",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),          actions: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseOrder_Form(tipe: "insert", po_no: "x")));
            }, icon: Icon(Icons.add)),
          ],
        ),
        body:Padding(padding: EdgeInsets.all(5),
        child:SingleChildScrollView(
          child: Container(
            child:  Column(
              children: [
                Search_PO(),
              ],
            )
          ),
        ),
        
        )   
    );
  }

  Widget Search_PO() {
    return Container(
      child: TextField(
        controller: _Search_PO,
        decoration: InputDecoration(
          labelText: "PO NO Search",
          labelStyle: TextStyle(fontSize: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(style: BorderStyle.solid,width: 1,color: Colors.black)
          )
        ),
         onChanged: (value) {
           value=_Search_PO.text;
         }, 

      ),
    );

  }
}