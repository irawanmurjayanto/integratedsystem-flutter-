import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseOrder_Form extends StatefulWidget {
  
  PurchaseOrder_Form({Key?key,required this.tipe,required this.po_no}):super(key: key);
  final String? tipe;
  final String? po_no; 

  @override
  State<PurchaseOrder_Form> createState() => _PurchaseOrder_FormState(tipe:tipe,po_no:po_no);
}

class _PurchaseOrder_FormState extends State<PurchaseOrder_Form> {
  final String? tipe;
  final String? po_no; 
  _PurchaseOrder_FormState({required this.tipe,required this.po_no});
 
    final _no_ref_po=TextEditingController();
    final _tgl_po=TextEditingController();

    get_noref_po(){
      final String tgl='PO-'+DateTime.now().millisecondsSinceEpoch.toString();
      setState(() {
        _no_ref_po.text=tgl;
      });
    }

    getTgl_Now() async{
    setState(() {
      _tgl_po.text=DateFormat('dd-MM-yyyy').format(DateTime.now());
    });
    }

    @override
  void initState() {
    get_noref_po();
    getTgl_Now();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Purchase Order"),
      ),
      backgroundColor: Colors.grey[350],
      body: Container(
        child: SingleChildScrollView(
           child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
                children: [
                  WG_No_ref_PO(),
                  SizedBox(height: 7,),
                  tgl_po(),
                ],
            ),
           ), 
        ),
      ),
      
    );
    
  }

  Widget tgl_po() {
    return Container(
      child: TextField(
        controller: _tgl_po,
        style: TextStyle(fontSize: 8),
        decoration: InputDecoration(
          labelText: "PO Date",       
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),    
        
             
          )
        ),
        onTap: () async {
          final DateTime?pickdate=await showDatePicker(context: context, 
          initialDate: DateTime.now(),
          firstDate: DateTime(1920), 
          lastDate: DateTime(2030));

          if (pickdate!=null)
          {
            setState(() {
              _tgl_po.text=DateFormat("dd-MM-yyyy").format(pickdate);
            });
          }
        },
      ),
    );
  }

  Widget WG_No_ref_PO(){
    return Container(
      //padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          color: Colors.black,

      ),
    
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
           border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),   ),
        ),
        style: TextStyle(fontSize: 10,color:Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.none),
        controller: _no_ref_po,
       
        onChanged: (value) {
          _no_ref_po.text=value;
        },
      ),
    );
  }

}